/*
 * ADagentView.java
 */

package adagent;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import org.jdesktop.application.Action;
import org.jdesktop.application.ResourceMap;
import org.jdesktop.application.SingleFrameApplication;
import org.jdesktop.application.FrameView;
import org.jdesktop.application.TaskMonitor;
import org.jdesktop.application.Task;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import javax.persistence.RollbackException;
import javax.swing.Timer;
import javax.swing.Icon;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import org.jdesktop.beansbinding.AbstractBindingListener;
import org.jdesktop.beansbinding.Binding;
import org.jdesktop.beansbinding.PropertyStateEvent;

/**
 * The application's main frame.
 */
public class ADagentView extends FrameView {
    
    public ADagentView(SingleFrameApplication app) {
        super(app);

        initComponents();
        initComponents2();
        // status bar initialization - message timeout, idle icon and busy animation, etc
        ResourceMap resourceMap = getResourceMap();
        int messageTimeout = resourceMap.getInteger("StatusBar.messageTimeout");
	messageTimer = new Timer(messageTimeout, new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                statusMessageLabel.setText("");
            }
        });
	messageTimer.setRepeats(false);
        int busyAnimationRate = resourceMap.getInteger("StatusBar.busyAnimationRate");
        for (int i = 0; i < busyIcons.length; i++) {
            busyIcons[i] = resourceMap.getIcon("StatusBar.busyIcons[" + i + "]");
        }
        busyIconTimer = new Timer(busyAnimationRate, new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                busyIconIndex = (busyIconIndex + 1) % busyIcons.length;
                statusAnimationLabel.setIcon(busyIcons[busyIconIndex]);
            }
        }); 
        idleIcon = resourceMap.getIcon("StatusBar.idleIcon");
        statusAnimationLabel.setIcon(idleIcon);
        progressBar.setVisible(false);

        // connecting action tasks to status bar via TaskMonitor
        TaskMonitor taskMonitor = new TaskMonitor(getApplication().getContext());
        taskMonitor.addPropertyChangeListener(new java.beans.PropertyChangeListener() {
            public void propertyChange(java.beans.PropertyChangeEvent evt) {
                String propertyName = evt.getPropertyName();
                if ("started".equals(propertyName)) {
                    if (!busyIconTimer.isRunning()) {
                        statusAnimationLabel.setIcon(busyIcons[0]);
                        busyIconIndex = 0;
                        busyIconTimer.start();
                    }
                    progressBar.setVisible(true);
                    progressBar.setIndeterminate(true);
                } else if ("done".equals(propertyName)) {
                    busyIconTimer.stop();
                    statusAnimationLabel.setIcon(idleIcon);
                    progressBar.setVisible(false);
                    progressBar.setValue(0);
                } else if ("message".equals(propertyName)) {
                    String text = (String)(evt.getNewValue());
                    statusMessageLabel.setText((text == null) ? "" : text);
                    messageTimer.restart();
                } else if ("progress".equals(propertyName)) {
                    int value = (Integer)(evt.getNewValue());
                    progressBar.setVisible(true);
                    progressBar.setIndeterminate(false);
                    progressBar.setValue(value);
                }
            }
        });

        // tracking table selection
        masterTable.getSelectionModel().addListSelectionListener(
            new ListSelectionListener() {
                public void valueChanged(ListSelectionEvent e) {
                    firePropertyChange("recordSelected", !isRecordSelected(), isRecordSelected());
                }
            });
        detailTable.getSelectionModel().addListSelectionListener(
            new ListSelectionListener() {
                public void valueChanged(ListSelectionEvent e) {
                    firePropertyChange("detailRecordSelected", !isDetailRecordSelected(), isDetailRecordSelected());
                }
            });

        // tracking changes to save
        bindingGroup.addBindingListener(new AbstractBindingListener() {
            @Override
            public void targetChanged(Binding binding, PropertyStateEvent event) {
                // save action observes saveNeeded property
                setSaveNeeded(true);
            }
        });

        // have a transaction started
        entityManager.getTransaction().begin();
    }


    public boolean isSaveNeeded() {
        return saveNeeded;
    }

    private void setSaveNeeded(boolean saveNeeded) {
        if (saveNeeded != this.saveNeeded) {
            this.saveNeeded = saveNeeded;
            firePropertyChange("saveNeeded", !saveNeeded, saveNeeded);
        }
    }

    public boolean isRecordSelected() {
        return masterTable.getSelectedRow() != -1;
    }
    
    public boolean isDetailRecordSelected() {
        return detailTable.getSelectedRow() != -1;
    }

    public boolean isOrderRecordSelected() {
        return orderTable.getSelectedRow() != -1;
    }

    @Action
    public void newRecord() {
        adagent.TEmployee T = new adagent.TEmployee();
        entityManager.persist(T);
        list.add(T);
        int row = list.size()-1;
        masterTable.setRowSelectionInterval(row, row);
        masterTable.scrollRectToVisible(masterTable.getCellRect(row, 0, true));
        setSaveNeeded(true);
    }

    @Action(enabledProperty = "recordSelected")
    public void deleteRecord() {
        int[] selected = masterTable.getSelectedRows();
        List<adagent.TEmployee> toRemove = new ArrayList<adagent.TEmployee>(selected.length);
        for (int idx=0; idx<selected.length; idx++) {
            adagent.TEmployee T = list.get(masterTable.convertRowIndexToModel(selected[idx]));
            removeAllOrder(T);
            toRemove.add(T);
            entityManager.remove(T);
        }
        list.removeAll(toRemove);
        setSaveNeeded(true);
    }

    private void removeAllOrder(TEmployee T) {
        Collection<adagent.TOrder> ts = T.getTOrderList();
        int[] selected = new int[detailTable.getRowCount()];
        for( int idx = 0 ; idx<selected.length ; idx++) selected[idx] = idx;
        List<adagent.TOrder> toRemove = new ArrayList<adagent.TOrder>(selected.length);
        for (int idx=0; idx<selected.length; idx++) {
            selected[idx] = detailTable.convertRowIndexToModel(selected[idx]);
            int count = 0;
            Iterator<adagent.TOrder> iter = ts.iterator();
            while (count++ < selected[idx]) iter.next();
            adagent.TOrder t = iter.next();
            toRemove.add(t);
            entityManager.remove(t);
        }
        ts.removeAll(toRemove);
    }
    
    @Action(enabledProperty = "detailRecordSelected")
    public void editDetailRecord() {
        int index = masterTable.getSelectedRow();
        adagent.TEmployee T = list.get(masterTable.convertRowIndexToModel(index));
        int selected = detailTable.getSelectedRow();
        TOrder editOrder = T.getTOrderList().get(detailTable.convertRowIndexToModel(selected));

        if(doEditDialog(editOrder) == 0)
            setSaveNeeded(true);
    }

    @Action(enabledProperty = "detailRecordSelected")
    public void deleteDetailRecord() {
        int index = masterTable.getSelectedRow();
        adagent.TEmployee T = list.get(masterTable.convertRowIndexToModel(index));
        Collection<adagent.TOrder> ts = T.getTOrderList();
        int[] selected = detailTable.getSelectedRows();
        List<adagent.TOrder> toRemove = new ArrayList<adagent.TOrder>(selected.length);
        for (int idx=0; idx<selected.length; idx++) {
            selected[idx] = detailTable.convertRowIndexToModel(selected[idx]);
            int count = 0;
            Iterator<adagent.TOrder> iter = ts.iterator();
            while (count++ < selected[idx]) iter.next();
            adagent.TOrder t = iter.next();
            toRemove.add(t);
            entityManager.remove(t);
        }
        ts.removeAll(toRemove);
        masterTable.clearSelection();
        masterTable.setRowSelectionInterval(index, index);
        setSaveNeeded(true);
    }

    @Action(enabledProperty = "saveNeeded")
    public Task save() {
        return new SaveTask(getApplication());
    }

    private class SaveTask extends Task {
        SaveTask(org.jdesktop.application.Application app) {
            super(app);
        }
        @Override protected Void doInBackground() {
            try {
                entityManager.getTransaction().commit();
                entityManager.getTransaction().begin();
            } catch (RollbackException rex) {
                rex.printStackTrace();
                entityManager.getTransaction().begin();
                List<adagent.TEmployee> merged = new ArrayList<adagent.TEmployee>(list.size());
                for (adagent.TEmployee T : list) {
                    merged.add(entityManager.merge(T));
                }
                list.clear();
                list.addAll(merged);
            }
            return null;
        }
        @Override protected void finished() {
            setSaveNeeded(false);
        }
    }

    /**
     * An example action method showing how to create asynchronous tasks
     * (running on background) and how to show their progress. Note the
     * artificial 'Thread.sleep' calls making the task long enough to see the
     * progress visualization - remove the sleeps for real application.
     */
    @Action
    public Task refresh() {
       return new RefreshTask(getApplication());
    }

    private class RefreshTask extends Task {
        RefreshTask(org.jdesktop.application.Application app) {
            super(app);
        }
        @SuppressWarnings("unchecked")
        @Override protected Void doInBackground() {
            try {
                setProgress(0, 0, 4);
                setMessage("Rolling back the current changes...");
                setProgress(1, 0, 4);
                entityManager.getTransaction().rollback();
                Thread.sleep(1000L); // remove for real app
                setProgress(2, 0, 4);

                setMessage("Starting a new transaction...");
                entityManager.getTransaction().begin();
                Thread.sleep(500L); // remove for real app
                setProgress(3, 0, 4);

                setMessage("Fetching new data...");
                java.util.Collection data, cdata, pdata, sdata;
                if(isAdminMode) {
                    data = query.getResultList();
                    for (Object entity : data) {
                        entityManager.refresh(entity);
                    }
                    cdata = tContTypeQuery.getResultList();
                    for (Object entity : cdata) {
                        entityManager.refresh(entity);
                    }
                    pdata = tPageTypeQuery.getResultList();
                    for (Object entity : pdata) {
                        entityManager.refresh(entity);
                    }
                    sdata = tSizeTypeQuery.getResultList();
                    for (Object entity : sdata) {
                        entityManager.refresh(entity);
                    }
                }
                else{
                    tOrderQuery.setParameter(1, currentUser.getEID());
                    data = tOrderQuery.getResultList();
                    for (Object entity : data) {
                        System.out.println(entity.toString());
                        entityManager.refresh(entity);
                    }
                    cdata = pdata = sdata = null;
                }
                Thread.sleep(1300L); // remove for real app
                setProgress(4, 0, 4);

                Thread.sleep(150L); // remove for real app
                if(isAdminMode){
                    list.clear();
                    list.addAll(data);
                    tContTypeList.clear();
                    tContTypeList.addAll(cdata);
                    tPageTypeList.clear();
                    tPageTypeList.addAll(pdata);
                    tSizeTypeList.clear();
                    tSizeTypeList.addAll(sdata);
                }
                else{
                    tOrderList.clear();
                    tOrderList.addAll(data);
                }
            } catch(InterruptedException ignore) { }
            return null;
        }
        @Override protected void finished() {
            setMessage("Done.");
            setSaveNeeded(false);
        }
    }

    @Action
    public void showAboutBox() {
        if (aboutBox == null) {
            JFrame mainFrame = ADagentApp.getApplication().getMainFrame();
            aboutBox = new ADagentAboutBox(mainFrame);
            aboutBox.setLocationRelativeTo(mainFrame);
        }
        ADagentApp.getApplication().show(aboutBox);
    }

    @Action
    public void editCustomerRecord() {
        
        Collection<adagent.TOrder> ts = tOrderList;
        adagent.TOrder t = new adagent.TOrder();

        t.setTEmployee(currentUser);
        tOrderList.add(t);
        int row = ts.size()-1;
        orderTable.setRowSelectionInterval(row, row);
        orderTable.scrollRectToVisible(orderTable.getCellRect(row, 0, true));
        
        
        int index = orderTable.getSelectedRow();
        adagent.TOrder T = tOrderList.get(orderTable.convertRowIndexToModel(index));

        if(doEditDialog(T) == 0) {
            entityManager.persist(t);
            setSaveNeeded(true);
        }
        else {
            orderTable.setRowSelectionInterval(row, row);
            tOrderList.remove(t);
        }
    }

    private int doEditDialog(adagent.TOrder T) {
        JFrame mainFrame = ADagentApp.getApplication().getMainFrame();
        CustomerOrder orderDialog = new CustomerOrder(mainFrame, false);
        orderDialog.setCurrentOrder(T);
        orderDialog.setVisible(true);

        java.util.Date odate = T.getAPostingDate();
        Short acont = T.getACont();
        Short apage = T.getAPage();
        Short asize = T.getASize();
        if(odate != null
                && acont != null && apage != null && asize != null
                && !T.getCName().equals("")) {
//            System.out.println(T.getCName().toString());
//            System.out.println(T.getACont().toString());
//            System.out.println(T.getAPage().toString());
//            System.out.println(T.getASize().toString());
//            System.out.println(T.getAPostingDate().toString());
            return 0;
        }

        return -1;
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        menuBar = new javax.swing.JMenuBar();
        javax.swing.JMenu fileMenu = new javax.swing.JMenu();
        loginMenuItem = new javax.swing.JMenuItem();
        logoutMenuItem = new javax.swing.JMenuItem();
        jSeparator1 = new javax.swing.JSeparator();
        javax.swing.JMenuItem exitMenuItem = new javax.swing.JMenuItem();
        javax.swing.JMenu helpMenu = new javax.swing.JMenu();
        javax.swing.JMenuItem aboutMenuItem = new javax.swing.JMenuItem();
        frameTab = new javax.swing.JTabbedPane();
        statusPanel = new javax.swing.JPanel();
        statusMessageLabel = new javax.swing.JLabel();
        statusAnimationLabel = new javax.swing.JLabel();
        progressBar = new javax.swing.JProgressBar();
        javax.swing.JSeparator statusPanelSeparator = new javax.swing.JSeparator();
        saveButton = new javax.swing.JButton();
        refreshButton = new javax.swing.JButton();
        loginDialog = new javax.swing.JDialog();
        jLabel1 = new javax.swing.JLabel();
        LoginButton = new javax.swing.JButton();
        userText = new javax.swing.JTextField();
        passwdText = new javax.swing.JPasswordField();
        jLabel2 = new javax.swing.JLabel();
        CancelButton = new javax.swing.JButton();
        alertDialog = new javax.swing.JDialog();
        jLabel3 = new javax.swing.JLabel();
        alertOK = new javax.swing.JButton();

        menuBar.setName("menuBar"); // NOI18N

        org.jdesktop.application.ResourceMap resourceMap = org.jdesktop.application.Application.getInstance(adagent.ADagentApp.class).getContext().getResourceMap(ADagentView.class);
        fileMenu.setText(resourceMap.getString("fileMenu.text")); // NOI18N
        fileMenu.setName("fileMenu"); // NOI18N

        javax.swing.ActionMap actionMap = org.jdesktop.application.Application.getInstance(adagent.ADagentApp.class).getContext().getActionMap(ADagentView.class, this);
        loginMenuItem.setAction(actionMap.get("loginUsers")); // NOI18N
        loginMenuItem.setText(resourceMap.getString("loginMenuItem.text")); // NOI18N
        loginMenuItem.setName("loginMenuItem"); // NOI18N
        fileMenu.add(loginMenuItem);

        logoutMenuItem.setAction(actionMap.get("logoutUsers")); // NOI18N
        logoutMenuItem.setText(resourceMap.getString("logoutMenuItem.text")); // NOI18N
        logoutMenuItem.setName("logoutMenuItem"); // NOI18N
        fileMenu.add(logoutMenuItem);

        jSeparator1.setName("jSeparator1"); // NOI18N
        fileMenu.add(jSeparator1);

        exitMenuItem.setAction(actionMap.get("quit")); // NOI18N
        exitMenuItem.setName("exitMenuItem"); // NOI18N
        fileMenu.add(exitMenuItem);

        menuBar.add(fileMenu);

        helpMenu.setText(resourceMap.getString("helpMenu.text")); // NOI18N
        helpMenu.setName("helpMenu"); // NOI18N

        aboutMenuItem.setAction(actionMap.get("showAboutBox")); // NOI18N
        aboutMenuItem.setName("aboutMenuItem"); // NOI18N
        helpMenu.add(aboutMenuItem);

        menuBar.add(helpMenu);

        frameTab.setName("frameTab"); // NOI18N

        statusPanel.setName("statusPanel"); // NOI18N
        statusPanel.setPreferredSize(new java.awt.Dimension(442, 100));

        statusMessageLabel.setName("statusMessageLabel"); // NOI18N

        statusAnimationLabel.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        statusAnimationLabel.setName("statusAnimationLabel"); // NOI18N

        progressBar.setName("progressBar"); // NOI18N

        statusPanelSeparator.setName("statusPanelSeparator"); // NOI18N

        saveButton.setAction(actionMap.get("save")); // NOI18N
        saveButton.setName("saveButton"); // NOI18N

        refreshButton.setAction(actionMap.get("refresh")); // NOI18N
        refreshButton.setName("refreshButton"); // NOI18N

        javax.swing.GroupLayout statusPanelLayout = new javax.swing.GroupLayout(statusPanel);
        statusPanel.setLayout(statusPanelLayout);
        statusPanelLayout.setHorizontalGroup(
            statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(statusPanelLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                        .addGroup(statusPanelLayout.createSequentialGroup()
                            .addComponent(statusMessageLabel)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 326, Short.MAX_VALUE)
                            .addComponent(progressBar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                            .addComponent(statusAnimationLabel)
                            .addContainerGap())
                        .addComponent(statusPanelSeparator, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.DEFAULT_SIZE, 486, Short.MAX_VALUE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, statusPanelLayout.createSequentialGroup()
                        .addComponent(refreshButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(saveButton)
                        .addContainerGap())))
        );
        statusPanelLayout.setVerticalGroup(
            statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, statusPanelLayout.createSequentialGroup()
                .addContainerGap(14, Short.MAX_VALUE)
                .addGroup(statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(saveButton)
                    .addComponent(refreshButton))
                .addGap(18, 18, 18)
                .addComponent(statusPanelSeparator, javax.swing.GroupLayout.PREFERRED_SIZE, 2, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(statusPanelLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(statusMessageLabel)
                    .addComponent(statusAnimationLabel)
                    .addComponent(progressBar, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(11, 11, 11))
        );

        loginDialog.setTitle(resourceMap.getString("loginDialog.title")); // NOI18N
        loginDialog.setBounds(new java.awt.Rectangle(0, 0, 300, 180));
        loginDialog.setModal(true);
        loginDialog.setModalExclusionType(java.awt.Dialog.ModalExclusionType.APPLICATION_EXCLUDE);
        loginDialog.setName("loginDialog"); // NOI18N
        loginDialog.setResizable(false);
        loginDialog.addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                loginDialogWindowClosing(evt);
            }
        });

        jLabel1.setText(resourceMap.getString("jLabel1.text")); // NOI18N
        jLabel1.setName("jLabel1"); // NOI18N

        LoginButton.setText(resourceMap.getString("LoginButton.text")); // NOI18N
        LoginButton.setName("LoginButton"); // NOI18N
        LoginButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                LoginButtonActionPerformed(evt);
            }
        });

        userText.setName("userText"); // NOI18N

        passwdText.setName("passwdText"); // NOI18N

        jLabel2.setText(resourceMap.getString("jLabel2.text")); // NOI18N
        jLabel2.setName("jLabel2"); // NOI18N

        CancelButton.setText(resourceMap.getString("CancelButton.text")); // NOI18N
        CancelButton.setName("CancelButton"); // NOI18N
        CancelButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                CancelButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout loginDialogLayout = new javax.swing.GroupLayout(loginDialog.getContentPane());
        loginDialog.getContentPane().setLayout(loginDialogLayout);
        loginDialogLayout.setHorizontalGroup(
            loginDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(loginDialogLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(loginDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel2)
                    .addComponent(jLabel1))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(loginDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, loginDialogLayout.createSequentialGroup()
                        .addComponent(LoginButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(CancelButton))
                    .addComponent(passwdText, javax.swing.GroupLayout.DEFAULT_SIZE, 208, Short.MAX_VALUE)
                    .addComponent(userText, javax.swing.GroupLayout.DEFAULT_SIZE, 208, Short.MAX_VALUE))
                .addContainerGap())
        );
        loginDialogLayout.setVerticalGroup(
            loginDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(loginDialogLayout.createSequentialGroup()
                .addContainerGap()
                .addGroup(loginDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel1)
                    .addComponent(userText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(loginDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(passwdText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel2))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(loginDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(CancelButton)
                    .addComponent(LoginButton))
                .addContainerGap(58, Short.MAX_VALUE))
        );

        alertDialog.setTitle(resourceMap.getString("alertDialog.title")); // NOI18N
        alertDialog.setBounds(new java.awt.Rectangle(0, 0, 320, 180));
        alertDialog.setIconImage(null);
        alertDialog.setIconImages(null);
        alertDialog.setModal(true);
        alertDialog.setModalExclusionType(java.awt.Dialog.ModalExclusionType.APPLICATION_EXCLUDE);
        alertDialog.setName("alertDialog"); // NOI18N
        alertDialog.setResizable(false);

        jLabel3.setText(resourceMap.getString("jLabel3.text")); // NOI18N
        jLabel3.setName("jLabel3"); // NOI18N

        alertOK.setText(resourceMap.getString("alertOK.text")); // NOI18N
        alertOK.setName("alertOK"); // NOI18N
        alertOK.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                alertOKActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout alertDialogLayout = new javax.swing.GroupLayout(alertDialog.getContentPane());
        alertDialog.getContentPane().setLayout(alertDialogLayout);
        alertDialogLayout.setHorizontalGroup(
            alertDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(alertDialogLayout.createSequentialGroup()
                .addGroup(alertDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(alertDialogLayout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jLabel3))
                    .addGroup(alertDialogLayout.createSequentialGroup()
                        .addGap(82, 82, 82)
                        .addComponent(alertOK)))
                .addContainerGap(101, Short.MAX_VALUE))
        );
        alertDialogLayout.setVerticalGroup(
            alertDialogLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(alertDialogLayout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel3)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(alertOK)
                .addContainerGap(101, Short.MAX_VALUE))
        );

        setComponent(frameTab);
        setMenuBar(menuBar);
        setStatusBar(statusPanel);
    }// </editor-fold>//GEN-END:initComponents

    private void LoginButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_LoginButtonActionPerformed
        if(adminUser.equals(userText.getText()) &&
                adminPasswd.equals(passwdText.getText())){
            dologinAdminMode();
            dologinSuccess();
            return;
        } else {
            for(adagent.TEmployee emp : list){
                if(emp.getEName().equals(userText.getText()) &&
                        emp.getEPassword().equals(passwdText.getText())){
                    dologinUserMode(emp);
                    dologinSuccess();
                    return;
                }
            }
        }
        alertDialog.show();
        return;
}//GEN-LAST:event_LoginButtonActionPerformed

    private void CancelButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_CancelButtonActionPerformed
        // TODO add your handling code here:
        System.exit(0);
}//GEN-LAST:event_CancelButtonActionPerformed

    private void loginDialogWindowClosing(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_loginDialogWindowClosing
        // TODO add your handling code here:
        System.exit(0);
}//GEN-LAST:event_loginDialogWindowClosing

    private void alertOKActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_alertOKActionPerformed
        // TODO add your handling code here:
        alertDialog.hide();
}//GEN-LAST:event_alertOKActionPerformed

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton CancelButton;
    private javax.swing.JButton LoginButton;
    private javax.swing.JDialog alertDialog;
    private javax.swing.JButton alertOK;
    private javax.swing.JTabbedPane frameTab;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JDialog loginDialog;
    private javax.swing.JMenuItem loginMenuItem;
    private javax.swing.JMenuItem logoutMenuItem;
    private javax.swing.JMenuBar menuBar;
    private javax.swing.JPasswordField passwdText;
    private javax.swing.JProgressBar progressBar;
    private javax.swing.JButton refreshButton;
    private javax.swing.JButton saveButton;
    private javax.swing.JLabel statusAnimationLabel;
    private javax.swing.JLabel statusMessageLabel;
    private javax.swing.JPanel statusPanel;
    private javax.swing.JTextField userText;
    // End of variables declaration//GEN-END:variables

    private adagent.TEmployee currentUser;
    private static final String adminUser= "admin";
    private static final String adminPasswd= "123";
    private boolean isAdminMode;

    private final Timer messageTimer;
    private final Timer busyIconTimer;
    private final Icon idleIcon;
    private final Icon[] busyIcons = new Icon[15];
    private int busyIconIndex = 0;

    private JDialog aboutBox;

    private boolean saveNeeded;

    private void initComponents2() {
        frameTab.setVisible(false);
        frameTab.setEnabledAt(0, false);
        frameTab.setEnabledAt(1, false);
        frameTab.setEnabledAt(2, false);
        logoutMenuItem.setEnabled(false);
    }

    private void dologinSuccess() {
        userText.setText("");
        passwdText.setText("");
        loginMenuItem.setEnabled(false);
        logoutMenuItem.setEnabled(true);
        frameTab.setVisible(true);
        this.refreshButton.doClick();
    }
  
    private void dologinAdminMode() {
        isAdminMode = true;
        System.out.println("Admin Mode");
        loginDialog.hide();
        frameTab.setSelectedIndex(2);
        frameTab.setEnabledAt(1, true);
        frameTab.setEnabledAt(2, true);
    }

    private void dologinUserMode(TEmployee emp) {
       isAdminMode = false;
        currentUser = emp;
        loginDialog.hide();
        System.out.println("Employee Mode:" + currentUser.getEName());
        displayEmployee.setText(currentUser.getEName());
        frameTab.setSelectedIndex(0);
        frameTab.setEnabledAt(0, true);
    }

    @Action
    public void loginUsers() {
        loginDialog.setVisible(true);
    }

    @Action
    public void logoutUsers() {
        initComponents2();
        currentUser = null;
        loginMenuItem.setEnabled(true);
    }
}

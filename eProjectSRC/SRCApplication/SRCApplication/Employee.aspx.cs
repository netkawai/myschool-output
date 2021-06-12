using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Web.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;

namespace WebApplication
{
    public partial class Employee : System.Web.UI.Page
    {
        SqlConnection sqlcon = null;
        SqlDataAdapter sqldaEmployee = null;
        DataSet dsetEmployee = null;
        DataTable dtableEmployee = null;

        protected void Page_Load(object sender, System.EventArgs e)
        {
            Debug.WriteLine("Page_Load");
            sqlcon = new SqlConnection(WebConfigurationManager.ConnectionStrings["y510.SRC.dbo"].ConnectionString);
            sqldaEmployee = new SqlDataAdapter("select * from tEmployee", sqlcon);
            dsetEmployee = new DataSet();
            sqldaEmployee.Fill(dsetEmployee, "tEmployee");
            dtableEmployee = dsetEmployee.Tables["tEmployee"];

            if (!Page.IsPostBack)
            {
                FillEmployeeDetails();
            }
        }

        private void FillEmployeeDetails() 
        {
            gvEmpResults.DataSource = dtableEmployee;
            gvEmpResults.DataBind(); 
        }

        protected void gvEmpResults_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEmpResults.EditIndex = -1;
            FillEmployeeDetails();
        }

        protected void gvEmpResults_RowEditing(object sender, GridViewEditEventArgs e)
        {
            Debug.WriteLine("RowEditing");

            int index = e.NewEditIndex;
            gvEmpResults.EditIndex = index;

            FillEmployeeDetails();

            TextBox eIDbox = (TextBox)(gvEmpResults.Rows[index].Cells[1].Controls[0]);
            eIDbox.Enabled = false;
        }

        protected void gvEmpResults_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Debug.WriteLine("RowUpdating");
            int index = e.RowIndex;
            GridViewRow row = gvEmpResults.Rows[index];
            DataRow empUpdate = dtableEmployee.Rows[index];
            empUpdate.BeginEdit();
            empUpdate["eName"] = ((TextBox)row.Cells[2].Controls[0]).Text;
            empUpdate["eContact"] = ((TextBox)row.Cells[3].Controls[0]).Text;
            empUpdate["ePassword"] = ((TextBox)row.Cells[4].Controls[0]).Text;
            empUpdate.EndEdit();
            SqlCommandBuilder cmd = new SqlCommandBuilder(sqldaEmployee);
            cmd.GetUpdateCommand();
            sqldaEmployee.Update(dsetEmployee, "tEmployee");

            gvEmpResults.EditIndex = -1;
            gvEmpResults.DataSource = dsetEmployee;
            gvEmpResults.DataBind();
        }

        protected void gvEmpResults_RowDeleteing(object sender, GridViewDeleteEventArgs e) 
        {
            int index = e.RowIndex;

            DataRow empDelete = dtableEmployee.Rows[index];
            empDelete.Delete();
            SqlCommandBuilder cmd = new SqlCommandBuilder(sqldaEmployee);
            cmd.GetDeleteCommand();

            sqldaEmployee.Update(dtableEmployee);

            FillEmployeeDetails();
        }

        protected void BtnAddNew_Click(object sender, EventArgs e)
        {
            DataRow empNew = dtableEmployee.NewRow();
            empNew.BeginEdit();
            empNew["eName"] = eNameBox.Text;
            empNew["eContact"] = eContactBox.Text;
            empNew["ePassword"] = ePasswordBox.Text;
            empNew.EndEdit();

            dtableEmployee.Rows.Add(empNew);
            SqlCommandBuilder cmd = new SqlCommandBuilder(sqldaEmployee);
            cmd.GetUpdateCommand();
            sqldaEmployee.Update(dsetEmployee, "tEmployee");

            FillEmployeeDetails();
        }
    }
}

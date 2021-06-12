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

namespace WebApplication
{
    public partial class Bus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void GridView1_AddNew(object sender, System.Web.UI.WebControls.CommandEventArgs e)
        {
            if (e.CommandName == "Insert")
            {
                GridViewRow row = GridView1.FooterRow;

                SqlDataSourceBus.InsertParameters[0].DefaultValue = ((TextBox)row.Cells[2].Controls[0].FindControl("bNameBox")).Text;
                SqlDataSourceBus.InsertParameters[1].DefaultValue = ((DropDownList)row.Cells[3].Controls[0].FindControl("DropDownListAdd1")).SelectedValue.ToString();

                SqlDataSourceBus.InsertParameters[2].DefaultValue = ((TextBox)row.Cells[4].Controls[0].FindControl("bSeatBox")).Text;
                SqlDataSourceBus.InsertParameters[3].DefaultValue = ((TextBox)row.Cells[5].Controls[0].FindControl("bDepartBox")).Text;

                SqlDataSourceBus.InsertParameters[4].DefaultValue = ((DropDownList)row.Cells[6].Controls[0].FindControl("DropDownListAdd2")).SelectedValue.ToString();
                SqlDataSourceBus.InsertParameters[5].DefaultValue = ((DropDownList)row.Cells[7].Controls[0].FindControl("DropDownListAdd3")).SelectedValue.ToString();

                SqlDataSourceBus.Insert();

                // After the order has been inserted, put the order in edit mode.
                GridView1.EditIndex = -1;
                GridView1.DataBind();
            }
        }
    }
}

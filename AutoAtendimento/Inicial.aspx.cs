using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AutoAtendimento
{
    public partial class Inicial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void OnClick_Levar(object sender, EventArgs e)
        {
            Session["viagem"] = "true";
            Response.Redirect("Default.aspx");
        }

        protected void OnClick_ComerAqui(object sender, EventArgs e)
        {
            Session["viagem"] = "false";
            Response.Redirect("default.aspx");
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AutoAtendimento
{
    public partial class AdicionaisTool : System.Web.UI.UserControl
    {
        public string Item
        {
            get
            {
                if (ViewState["Item"] == null)
                    return "";

                return (string)ViewState["Item"];
            }
            set
            {
                if (this.Item != value)
                {
                    Reset();
                }
                ViewState["Item"] = value;
                //ConfigureView();
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {

        }
       
        private void Reset()
        {
            ////Clear previous values
            //this.TempLabel.Text = "$ 0";
            //this.ProductCount = "";
        }

        protected void ProductsView_DataBound(object sender, EventArgs e)
        {

        }
    }
}
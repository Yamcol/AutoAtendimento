<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicial.aspx.cs" Inherits="AutoAtendimento.Inicial" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" href="styles/Inicial.css" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />

        <div style="text-align: center; padding-top: 300px">

            <div class="div1">
                <asp:ImageButton runat="server" CssClass="botao" Text="Comer Aqui?" BackColor="Black" OnClick="OnClick_ComerAqui" />
            </div>            
            <div class="div2">
                <asp:ImageButton runat="server" CssClass="botao2" Text="Para Levar?" BackColor="Black" OnClick="OnClick_Levar" />
            </div>

        </div>
        
    </form>
</body>
</html>

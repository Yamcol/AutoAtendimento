<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdicionaisTool.ascx.cs" Inherits="AutoAtendimento.AdicionaisTool" %>
<div class="demo-containers">
    <div class="demo-container size-medium no-bg">
        <div class="wrapper2">
            <ul>
                <asp:Repeater ID="repeater1" runat="server" DataSourceID="sql">
                    <ItemTemplate>
                        <li>
                            <div id="smallImage" runat="server">
                                <div style="width: 130px; height: 130px; background-position: center; background-repeat: no-repeat; background-image: url('<%# Eval("imagem", "{0}") %>');">
                                </div>
                            </div>
                            <div style="height: 70px; width: 130px;">
                                <hr style="width: 30px; margin-left: 10px; text-align: left;" />
                                <asp:Label ID="Label1" runat="server" Style="margin-left: 10px; display: block; font-size: 11pt;"><%# Eval("adicional")%></asp:Label>
                                <asp:Label ID="lblName" runat="server" Style="margin-left: 10px; display: block; font-size: 11pt;"><%# Eval("preco","{0:C}")%></asp:Label>
                            </div>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
            <asp:SqlDataSource runat="server" ID="sql" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from adicionais"></asp:SqlDataSource>
        </div>
    </div>
</div>
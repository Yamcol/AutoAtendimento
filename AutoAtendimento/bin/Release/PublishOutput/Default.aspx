<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AutoAtendimento.Default" %>

<!DOCTYPE html>

<html oncontextmenu="return false" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" href="styles/TreeList.Teste1.css" />
    <link rel="Stylesheet" href="styles/Wizard.Teste1.css" />
    <link rel="Stylesheet" href="styles/Wizard.alano.css" />
    <link rel="Stylesheet" type="text/css" href="styles/TileList.alanotilelist.css" />
</head>
<body >
    <form id="form1" runat="server" >
        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
            <script type="text/javascript">
                function OnClientTileClicking(titleList, args) {

                    //Refresh no RadClientDataSource
                    <%--dataSource = $find('<%= sql.ClientID %>');
                    dataSource.fetch();--%>

                    $find("<%=RadWindow1.ClientID %>").show();

                    //var tooltip = $find("RadToolTip3");
                    //tooltip.show();

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();
                    var item = "Add1:" + preco + ":" + produto;

                    $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);

                }
                    //click bebida
                function OnClientTileClicking1(titleList, args) {

                    $find("<%=RadWindowBebidas.ClientID %>").show();
                   
                }

                //click sobremesa
                function OnClientTileClicking2(titleList, args) {

                    $find("<%=RadWindowSobremesas.ClientID %>").show();

                }             

                // click TileAdicionais
                function OnClientTileAdicionais(titleList, args) {

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();

                    var selected = args.get_tile().get_selected();
                    if (!selected) {

                        var item = "Add2:" + preco + ":" + produto;

                        args.get_tile().set_selected(true);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }
                    
                    else {

                        var item = "Rem:" + preco + ":" + produto;
                        args.get_tile().set_selected(false);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }
                }

                // click TileBebidas
                function OnClientTileBebidas(titleList, args) {

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();

                    var selected = args.get_tile().get_selected();
                    if (!selected) {

                        var item = "Add2:" + preco + ":" + produto;

                        args.get_tile().set_selected(true);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }

                    else {

                        var item = "Rem:" + preco + ":" + produto;
                        args.get_tile().set_selected(false);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }
                }

                // click TileSobremesas
                function OnClientTileSobremesas(titleList, args) {

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();

                    var selected = args.get_tile().get_selected();
                    if (!selected) {

                        var item = "Add2:" + preco + ":" + produto;

                        args.get_tile().set_selected(true);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }

                    else {

                        var item = "Rem:" + preco + ":" + produto;
                        args.get_tile().set_selected(false);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }
                }


                // confirma TileList adicional
                function windowConfirmacao(sender, args) {

                    $find("<%=RadWindow1.ClientID %>").close();

                    var dataSource = $find('<%= RadTileList2.ClientID %>');
                    dataSource.clearSelection();
                }

                // confirma TileList bebida
                function windowConfirmacao1(sender, args) {

                    $find("<%=RadWindowBebidas.ClientID %>").close();

                    var dataSource = $find('<%= RadTileListBebida.ClientID %>');
                    dataSource.clearSelection();
                }

                // confirma TileList sobremesa
                function windowConfirmacao2(sender, args) {

                    $find("<%=RadWindowSobremesas.ClientID %>").close();

                    var dataSource = $find('<%= RadTileListSobremesas.ClientID %>');
                    dataSource.clearSelection();
                }

                // fecha window adicional
                function windowFechar(sender, args) {

                    $find("<%=RadWindow1.ClientID %>").close();
                }

                // fecha window bebida
                function windowFechar1(sender, args) {

                    $find("<%=RadWindowBebidas.ClientID %>").close();
                }

                // fecha window sobremesa
                function windowFechar2(sender, args) {

                    $find("<%=RadWindowSobremesas.ClientID %>").close();
                }

                // define o botão de impressão
                function clientWizard(sender, args) {
                    var com = args.get_command();

                    switch (com) {
                        case 2: 

                            var item = "imprimir:"

                            $find("<%=AjaxManager.ClientID %>").ajaxRequest(item);

                            break;
                    }
                }

            </script>
        </telerik:RadScriptBlock>

        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
        <telerik:RadAjaxManager runat="server" ID="AjaxManager" OnAjaxRequest="AjaxManager_AjaxRequest">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="AjaxManager">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lbProteina" />
                        <telerik:AjaxUpdatedControl ControlID="RadTreeList1" />
                        <telerik:AjaxUpdatedControl ControlID="lbTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadTreeList1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="lbTotal" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <div>
            <telerik:RadClientDataSource runat="server" ID="RadClientDataSource1">
                <DataSource>
                    <WebServiceDataSourceSettings BaseUrl="api/">
                        <Select Url="proteinas" DataType="JSON" />
                    </WebServiceDataSourceSettings>
                </DataSource>
            </telerik:RadClientDataSource>

            <telerik:RadClientDataSource runat="server" ID="RadClientDataSource2">
                <DataSource>
                    <WebServiceDataSourceSettings BaseUrl="api/">
                        <Select Url="adicionais" DataType="JSON" />
                    </WebServiceDataSourceSettings>
                </DataSource>
            </telerik:RadClientDataSource>

            <telerik:RadClientDataSource runat="server" ID="RadClientDataSource3">
                <DataSource>
                    <WebServiceDataSourceSettings BaseUrl="api/">
                        <Select Url="bebidas" DataType="JSON" />
                    </WebServiceDataSourceSettings>
                </DataSource>
            </telerik:RadClientDataSource>

            <telerik:RadClientDataSource runat="server" ID="RadClientDataSource4">
                <DataSource>
                    <WebServiceDataSourceSettings BaseUrl="api/">
                        <Select Url="sobremesas" DataType="JSON" />
                    </WebServiceDataSourceSettings>
                </DataSource>
            </telerik:RadClientDataSource>

            <div runat="server" id="DivPrincipal" style="width: 70%; float: left">
                <telerik:RadWizard ID="RadWizard1" Font-Size="18" Skin="Glow" runat="server" OnClientButtonClicking="clientWizard">
                    <Localization Next="Próximo" Previous="Anterior" Cancel="Cancelar" Finish="Finalizar Pedido" />
                    <WizardSteps>
                        <telerik:RadWizardStep ID="Proteina" Title="Proteína" Font-Size="12" runat="server" StepType="Start">
                            <telerik:RadTileList runat="server" Skin="Glow" CssClass="RadTileList_alanotilelist" SelectionMode="None" ID="RadTileList1" Height="500px" ScrollingMode="Auto" OnClientTileClicking="OnClientTileClicking" DataSourceID="sql1">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="proteina" TileType="RadContentTemplateTile" DataTargetField="preco" DataGroupNameField="grupo"  />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "proteina") %>' />
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="lbAdicional" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "proteina")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="RadLabel2" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql1" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select a.*, b.grupo from proteinas a join proteina_grupo b on a.id_grupo = b.id_grupo"></asp:SqlDataSource>
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep ID="Bebida" Font-Size="12" runat="server" StepType="Step" Title="Bebida">
                            <telerik:RadTileList runat="server" Skin="Glow" SelectionMode="None" ID="RadTileList3" OnClientTileClicking="OnClientTileClicking1" ScrollingMode="Auto" Height="500px" DataSourceID="sql2">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="bebida" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage2" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "bebida") %>' />
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="lbBebida" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "bebida")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql2" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from bebidas"></asp:SqlDataSource>
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep ID="Sobremesa" Font-Size="12" runat="server" StepType="Step" CssClass="chartStep">
                            <telerik:RadTileList runat="server" Skin="Glow" SelectionMode="None" CssClass="RadTileList_alanotilelist" OnClientTileClicking="OnClientTileClicking2" ID="RadTileList4" Height="500px" EnableDragAndDrop="true"
                                DataSourceID="sql3">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="sobremesa" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage3" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "sobremesa") %>' />
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="lbSobremesa" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "sobremesa")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="RadLabel2" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql3" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from sobremesas"></asp:SqlDataSource>
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep Font-Size="25" ID="Finalizar" runat="server" StepType="Finish" CssClass="chartStep">
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 200px">
                                        <telerik:RadLabel runat="server" ID="lbNome" ForeColor="White" Text="Nome:"></telerik:RadLabel>
                                    </td>
                                    <td style="width: 400px">
                                        <telerik:RadTextBox runat="server" ID="txtNome" Width="100%"></telerik:RadTextBox>
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 200px">
                                        <telerik:RadLabel runat="server" ID="lbTelefone" ForeColor="White" Text="Telefone:"></telerik:RadLabel>
                                    </td>
                                    <td style="width: 400px">
                                        <telerik:RadTextBox runat="server" ID="txbTelefone" InputType="Tel" Width="100%"></telerik:RadTextBox>
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                        </telerik:RadWizardStep>
                    </WizardSteps>
                </telerik:RadWizard>

                <telerik:RadToolTip RenderMode="Lightweight" runat="server" ID="RadToolTip3" HideEvent="FromCode" Position="Center"
                    Animation="Slide" ShowEvent="FromCode" Modal="true" Title="Adicionais" Width="900px" Height="500px" RenderInPageRoot="true">
                    <telerik:RadLabel runat="server" ID="lbPrincipal" Skin="BlackMetroTouch" Text="ADICIONAIS PARA:"></telerik:RadLabel>
                    <telerik:RadLabel runat="server" ID="lbProteina" Skin="BlackMetroTouch"></telerik:RadLabel>
                    <telerik:RadLabel runat="server" ID="lbId" Visible="false"></telerik:RadLabel>
                </telerik:RadToolTip>

                <telerik:RadWindow RenderMode="Lightweight" Title="Adicionais" Modal="true" ID="RadWindow1" Width="800px" Height="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" Skin="Glow" ID="RadTileList2" SelectionMode="Multiple" OnClientTileClicking="OnClientTileAdicionais" Height="400px"
                            DataSourceID="sql" ScrollingMode="None" Width="100%">
                            <DataBindings>
                                <CommonTileBinding DataNameField="adicional" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                <ContentTemplateTileBinding>
                                    <ContentTemplate>
                                        <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                            AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "adicional") %>' />
                                        <div style="padding-left: 5px">
                                            <telerik:RadLabel runat="server" ID="lbAdicional" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "adicional")%>'></telerik:RadLabel>
                                        </div>
                                        <div style="padding-left: 5px">
                                            <telerik:RadLabel runat="server" ID="RadLabel2" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                        </div>
                                    </ContentTemplate>
                                </ContentTemplateTileBinding>
                            </DataBindings>
                        </telerik:RadTileList>
                        <table width="100%">
                            <tr>
                                <td>
                                    <telerik:RadButton runat="server" ID="btnOk" Text="Confimar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowConfirmacao" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton1" Text="Fechar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowFechar" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                <asp:SqlDataSource runat="server" ID="sql" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from adicionais"></asp:SqlDataSource>

                <telerik:RadWindow RenderMode="Lightweight" Title="Bebidas" Modal="true" ID="RadWindowBebidas" Width="800px" Height="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" Skin="Glow" ID="RadTileListBebida" SelectionMode="Multiple" Height="400px" OnClientTileClicking="OnClientTileBebidas"
                            DataSourceID="SqlBebida" ScrollingMode="None" Width="100%"> 
                            <DataBindings>
                                    <CommonTileBinding DataNameField="bebida" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImageBebida" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "bebida") %>' />
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="lbBebida" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "bebida")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="RadLabelBebida" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                        </telerik:RadTileList>
                        <table width="100%">
                            <tr>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton2" Text="Confimar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowConfirmacao1" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton3" Text="Fechar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowFechar1" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                 <asp:SqlDataSource runat="server" ID="SqlBebida" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from bebidas"></asp:SqlDataSource>

                <telerik:RadWindow RenderMode="Lightweight" Title="Sobremesas" Modal="true" ID="RadWindowSobremesas" Width="800px" Height="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" Skin="Glow" ID="RadTileListSobremesas" SelectionMode="Multiple" Height="400px" OnClientTileClicking="OnClientTileSobremesas"
                            DataSourceID="SqlSobremesas" ScrollingMode="None" Width="100%"> 
                            <DataBindings>
                                    <CommonTileBinding DataNameField="sobremesa" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImageSobremesa" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "sobremesa") %>' />
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="lbSobremesa" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "sobremesa")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="RadLabelSobremesa" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                        </telerik:RadTileList>
                        <table width="100%">
                            <tr>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton4" Text="Confimar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowConfirmacao2" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                                <td>
                                    <telerik:RadButton runat="server" ID="RadButton5" Text="Fechar" Width="120px" BackColor="WhiteSmoke" AutoPostBack="false" OnClientClicking="windowFechar2" Height="65px">
                                        <Icon PrimaryIconCssClass="rbOk" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                 <asp:SqlDataSource runat="server" ID="SqlSobremesas" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from sobremesas"></asp:SqlDataSource>
            </div>

            <div style="width: 29%; float: left; padding-left:2px; padding-right: 4px; padding-top: 100px">
                <telerik:RadTreeList runat="server" Skin="Glow" ID="RadTreeList1" DataKeyNames="id" OnNeedDataSource="RadTreeList1_NeedDataSource" ParentDataKeyNames="id_proteina"
                    AutoGenerateColumns="false" ShowTreeLines="false" ShowOuterBorders="true" GridLines="Horizontal" Height="400px" OnDeleteCommand="RadTreeList1_DeleteCommand">
                    <ClientSettings>
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" />
                    </ClientSettings>
                    <Columns>
                        <telerik:TreeListBoundColumn DataField="id" UniqueName="id" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="id_proteina" UniqueName="id_proteina" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="proteina" UniqueName="proteina" ItemStyle-Font-Size="8" HeaderText="Itens" HeaderStyle-Font-Bold="true" FooterText="Total">
                            <HeaderStyle HorizontalAlign="Center" />
                        </telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="preco" ItemStyle-Font-Size="8" HeaderText="Valor" HeaderStyle-Font-Bold="true" DataFormatString="{0:n}" Aggregate="Sum" FooterAggregateFormatString="{0:n}">
                            <HeaderStyle HorizontalAlign="Center" Width="60px" />
                            <ItemStyle HorizontalAlign="Right" />
                        </telerik:TreeListBoundColumn>
                        <telerik:TreeListButtonColumn UniqueName="DeleteCommandColumn" ItemStyle-ForeColor="Red" HeaderStyle-Font-Size="20" Text="Delete" CommandName="Delete"
                            ButtonType="FontIconButton" HeaderStyle-Width="50px">
                        </telerik:TreeListButtonColumn>
                    </Columns>
                    <FooterItemStyle HorizontalAlign="Right" Font-Bold="true" />
                </telerik:RadTreeList>

                 
            </div>
            <div style="width: 30%; float: right; padding-top: 40px">
                <telerik:RadLabel runat="server" ID="lbTotal" Font-Bold="true" Font-Size="24px"></telerik:RadLabel>
            </div>

        </div>
    </form>
</body>
</html>

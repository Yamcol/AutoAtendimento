<%@ Page Language="C#" AutoEventWireup="true" Async="true" CodeBehind="Default.aspx.cs" Inherits="AutoAtendimento.Default" %>

<!DOCTYPE html>

<html oncontextmenu="return false" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" href="styles/TileSizes.css" />
    <link rel="Stylesheet" href="styles/TileSizesPais.css" />
    <link rel="Stylesheet" href="styles/WizardColor1.css" />
    <link rel="Stylesheet" href="styles/TreeList.Teste1.css" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">
            <script type="text/javascript">

                //flag proteina -> controla a impressão para a cozinha (só são impressas as proteinas e adicionais da treeList)

                function OnClientTileClicking(titleList, args) {

                    //click proteina
                    $find("<%=RadWindowAdicionais.ClientID %>").show();
                    
                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();
                    var item = "Add1:" + preco + ":" + produto + ":proteina";

                    $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);

                }
                    //click bebida
                function OnClientTileClicking1(titleList, args) {
                                        
                    var produto = args.get_tile().get_name();

                    if (produto.match(/ÁGUA/)) {
                        var preco = args.get_tile().get_target();
                        var item = "Add1:" + preco + ":" + produto + ":";
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }
                    else {
                        var preco = args.get_tile().get_target();
                        var item = "Add1:" + preco + ":" + produto + ":";
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                        $find("<%=RadWindowBebidas.ClientID %>").show();
                    }        
                }

                //click sobremesa
                function OnClientTileClicking2(titleList, args) {

                    $find("<%=RadWindowSobremesas.ClientID %>").show();

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();
                    var item = "Add1:" + preco + ":" + produto + ":";

                    $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);

                }             

                // click TileAdicionais
                function OnClientTileAdicionais(titleList, args) {

                    var preco = args.get_tile().get_target();
                    var produto = args.get_tile().get_name();

                    var selected = args.get_tile().get_selected();
                    if (!selected) {

                        var item = "Add2:" + preco + ":" + produto + ":proteina";

                        args.get_tile().set_selected(true);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }
                    
                    else {

                        var item = "Rem:" + preco + ":" + produto + ":";
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

                        var item = "Add2:" + preco + ":" + produto + ":";

                        args.get_tile().set_selected(true);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }

                    else {

                        var item = "Rem:" + preco + ":" + produto + ":";
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

                        var item = "Add2:" + preco + ":" + produto + ":";

                        args.get_tile().set_selected(true);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }

                    else {

                        var item = "Rem:" + preco + ":" + produto + ":";
                        args.get_tile().set_selected(false);
                        $find("<%=AjaxManager.ClientID%>").ajaxRequest(item);
                    }
                }


                // confirma TileList adicional
                function windowConfirmacao(sender, args) {

                    $find("<%=RadWindowAdicionais.ClientID %>").close();

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

                    $find("<%=RadWindowAdicionais.ClientID %>").close();
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
            <div runat="server" id="DivPrincipal" style="width: 70%; float: left">
                <telerik:RadWizard ID="RadWizard1" BackColor="Transparent" CssClass="RadWizard_A" Font-Size="18" runat="server" OnClientButtonClicking="clientWizard">
                    <Localization Next="Próximo" Previous="Anterior" Cancel="Cancelar" Finish="Finalizar Pedido" />
                    <WizardSteps>
                        <telerik:RadWizardStep ID="Proteina" Title="Proteína" Font-Size="12" runat="server" StepType="Start">
                            <telerik:RadTileList runat="server" CssClass="SizeTilesPais" ForeColor="Black" OnTileDataBound="RadTileList1_OnTileDataBound" Skin="Glow" SelectionMode="None" ID="RadTileList1" Height="500px" ScrollingMode="Auto" OnClientTileClicking="OnClientTileClicking" DataSourceID="sql1">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="produto" TileType="RadContentTemplateTile" DataTargetField="preco"  DataGroupNameField="subgrupo" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "produto") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbAdicional" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "produto")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="RadLabel2" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>                                    
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql1" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select subgrupo.subgrupo,produtos.* from produtos JOIN subgrupo on subgrupo.id_subgrupo = produtos.id_subgrupo where produtos.id_grupo = 1 and produtos.disponivel_venda=1"></asp:SqlDataSource>
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep ID="Bebida" Font-Size="12" runat="server" StepType="Step" Title="Bebida">
                            <telerik:RadTileList runat="server" CssClass="SizeTilesPais" ForeColor="Black" OnTileDataBound="RadTileList1_OnTileDataBound" Skin="Glow" SelectionMode="None" ID="RadTileList3" OnClientTileClicking="OnClientTileClicking1" ScrollingMode="Auto" Height="500px" DataSourceID="sql2">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="produto" TileType="RadContentTemplateTile" DataTargetField="preco" DataGroupNameField="subgrupo" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage2" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "produto") %>' />
                                            <div style="padding-left: 5px">
                                                <telerik:RadLabel runat="server" ID="lbBebida" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "produto")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql2" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select subgrupo.subgrupo,produtos.* from produtos JOIN subgrupo on subgrupo.id_subgrupo = produtos.id_subgrupo where produtos.id_grupo = 2 and produtos.disponivel_venda=1"></asp:SqlDataSource>
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep ID="Sobremesa" Font-Size="12" runat="server" StepType="Step" CssClass="chartStep">
                            <telerik:RadTileList runat="server" CssClass="SizeTilesPais" ForeColor="Black" OnTileDataBound="RadTileList1_OnTileDataBound" Skin="Glow" SelectionMode="None" OnClientTileClicking="OnClientTileClicking2" ID="RadTileList4" Height="500px" DataSourceID="sql3">
                                <DataBindings>
                                    <CommonTileBinding DataNameField="produto" TileType="RadContentTemplateTile" DataTargetField="preco"  DataGroupNameField="subgrupo"/>
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage3" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="170px" Height="120px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "produto") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbSobremesa" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "produto")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="RadLabel2" Font-Size="10px" ForeColor="White" Text='  <%#DataBinder.Eval(Container.DataItem, "preco", "{0:c}")%>'></telerik:RadLabel>
                                            </div>
                                        </ContentTemplate>
                                    </ContentTemplateTileBinding>
                                </DataBindings>
                            </telerik:RadTileList>
                            <asp:SqlDataSource runat="server" ID="sql3" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select subgrupo.subgrupo,produtos.* from produtos JOIN subgrupo on subgrupo.id_subgrupo = produtos.id_subgrupo where produtos.id_grupo = 4 and produtos.disponivel_venda=1"></asp:SqlDataSource>
                        </telerik:RadWizardStep>

                        <telerik:RadWizardStep Font-Size="25" ID="Finalizar" runat="server" StepType="Finish" CssClass="chartStep">
                            <table style="width: 100%">
                                <tr>
                                    <td style="width: 200px">
                                        <telerik:RadLabel runat="server" ID="lbNome" ForeColor="Black" Text="Nome:"></telerik:RadLabel>
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
                                        <telerik:RadLabel runat="server" ID="lbTelefone" ForeColor="black" Text="Telefone:"></telerik:RadLabel>
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

                <div>
                    <telerik:RadLabel runat="server" ID="RadLabel1" Font-Size="5" Text="Imagens meramente ilustrativas"></telerik:RadLabel>
                </div>

                <telerik:RadToolTip RenderMode="Lightweight" runat="server" ID="RadToolTip3" HideEvent="FromCode" Position="Center"
                    Animation="Slide" ShowEvent="FromCode" Modal="true" Title="Adicionais" Width="900px" Height="500px" RenderInPageRoot="true">
                    <telerik:RadLabel runat="server" ID="lbPrincipal" Skin="BlackMetroTouch" Text="ADICIONAIS PARA:"></telerik:RadLabel>
                    <telerik:RadLabel runat="server" ID="lbProteina" Skin="BlackMetroTouch"></telerik:RadLabel>
                    <telerik:RadLabel runat="server" ID="lbId" Visible="false"></telerik:RadLabel>
                </telerik:RadToolTip>

                <telerik:RadWindow RenderMode="Lightweight" Title="Adicionais" Modal="true" ID="RadWindowAdicionais" MinWidth="500px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList CssClass="CustomSizeTiles" runat="server" Skin="Glow" ID="RadTileList2" OnClientTileClicking="OnClientTileAdicionais" Height="400px"
                            DataSourceID="sql" ScrollingMode="Auto" Width="100%">
                            <DataBindings>
                                <CommonTileBinding DataNameField="produto" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                <ContentTemplateTileBinding>
                                    <ContentTemplate>
                                        <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                            AutoAdjustImageControlSize="false" Width="150px" Height="105px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "produto") %>' />
                                        <div style="padding-left: 5px; margin-top: -5px">
                                            <telerik:RadLabel runat="server" ID="lbAdicional" Font-Size="10px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "produto")%>'></telerik:RadLabel>
                                        </div>
                                        <div style="padding-left: 5px; margin-top: -5px">
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
                            </tr>
                        </table>
                    </ContentTemplate>
                </telerik:RadWindow>
                <asp:SqlDataSource runat="server" ID="sql" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from produtos where id_grupo = 3 and produtos.disponivel_venda=1"></asp:SqlDataSource>

                <telerik:RadWindow RenderMode="Lightweight" Title="Bebidas" Modal="true" ID="RadWindowBebidas" MinWidth="500px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" CssClass="CustomSizeTiles" Skin="Glow" ID="RadTileListBebida" Height="400px" OnClientTileClicking="OnClientTileBebidas"
                            DataSourceID="SqlBebidaSabor" ScrollingMode="None" Width="100%"> 
                            <DataBindings>
                                    <CommonTileBinding DataNameField="sabor" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImageBebida" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="150px" Height="105px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "sabor") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbBebida" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "sabor")%>'></telerik:RadLabel>
                                            </div>
                                            <div style="padding-left: 5px; margin-top: -5px">
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
                 <asp:SqlDataSource runat="server" ID="SqlBebidaSabor" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from sabores_bebidas where disponivel_venda=1"></asp:SqlDataSource>

                <telerik:RadWindow RenderMode="Lightweight" Title="Sobremesas" Modal="true" ID="RadWindowSobremesas" MinWidth="500px" MinHeight="600px" runat="server" Behaviors="None">
                    <ContentTemplate>
                        <telerik:RadTileList runat="server" CssClass="CustomSizeTiles" Skin="Glow" ID="RadTileListSobremesas" Height="400px" OnClientTileClicking="OnClientTileSobremesas"
                            DataSourceID="SqlSobremesas" ScrollingMode="None" Width="100%"> 
                            <DataBindings>
                                    <CommonTileBinding DataNameField="sabor" TileType="RadContentTemplateTile" DataTargetField="preco" />
                                    <ContentTemplateTileBinding>
                                        <ContentTemplate>
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImageSobremesa" DataValue='<%# DataBinder.Eval(Container.DataItem, "imagem_bin") == DBNull.Value? new System.Byte[0]: DataBinder.Eval(Container.DataItem, "imagem_bin") %>'
                                                AutoAdjustImageControlSize="false" Width="150px" Height="105px" AlternateText='<%#DataBinder.Eval(Container.DataItem, "sabor") %>' />
                                            <div style="padding-left: 5px; margin-top: -5px">
                                                <telerik:RadLabel runat="server" ID="lbSobremesa" Font-Size="12px" ForeColor="White" Text='<%#DataBinder.Eval(Container.DataItem, "sabor")%>'></telerik:RadLabel>
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
                 <asp:SqlDataSource runat="server" ID="SqlSobremesas" ConnectionString="<%$ ConnectionStrings: conexao %>" SelectCommand="select * from sabores_sobremesas where disponivel_venda=1"></asp:SqlDataSource>
            </div>

            <div>
                <img src="images/logo-resto.png" alt="Sample Photo" height="100px" width="200px" style="padding-left:130px; padding-right: 4px; padding-top: 10px"/>
            </div>

            <div style="width: 29%; float: left; padding-left:2px; padding-right: 4px">
                <telerik:RadTreeList runat="server" CssClass="RadTreeList_Teste1" ID="RadTreeList1" DataKeyNames="id" OnNeedDataSource="RadTreeList1_NeedDataSource" ParentDataKeyNames="id_proteina" OnSelectedIndexChanged="RadTreeList1_SelectedIndexChanged"
                    AutoGenerateColumns="false" ShowTreeLines="false" ShowOuterBorders="true" GridLines="Horizontal" Height="400px" OnDeleteCommand="RadTreeList1_DeleteCommand">
                    <ClientSettings>
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" SaveScrollPosition="true" />
                    </ClientSettings>
                    <Columns>
                        <telerik:TreeListBoundColumn DataField="id" UniqueName="id" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="id_proteina" UniqueName="id_proteina" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="tipo" UniqueName="tipo" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="parentesco" UniqueName="parentesco" Display="false"></telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="proteina" UniqueName="proteina" ItemStyle-Font-Size="8" HeaderText="Itens" HeaderStyle-Font-Bold="true" FooterText="Total">
                            <HeaderStyle HorizontalAlign="Center" />
                        </telerik:TreeListBoundColumn>
                        <telerik:TreeListBoundColumn DataField="preco" UniqueName="item_preco" ItemStyle-Font-Size="8" HeaderText="Valor" HeaderStyle-Font-Bold="true" DataFormatString="{0:n}" Aggregate="Sum" FooterAggregateFormatString="{0:n}">
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

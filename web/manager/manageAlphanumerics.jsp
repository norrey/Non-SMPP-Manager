
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>


<rich:panel  style="margin-right:auto; margin-left:auto;" rendered="#{userScrollerBean.currentAlpha.message ne null}">
    <h:outputLabel  value="#{userScrollerBean.currentAlpha.message}" id="updateMessage" styleClass="success"/>
</rich:panel>

<rich:panel style="margin-left:auto; margin-right:auto" header="AVAILABLE USER ALPHANUMERICS">
    <h:form>
        <h:panelGrid width="100%" style="margin-left:auto; margin-right:auto; text-align:right">
            <h:commandLink action="#{alpha.generateXSL()}" id="export_excel_link">
                <h:graphicImage value="/resources/images/icons/icon-xls.gif" style="border:0" >
                </h:graphicImage>
            </h:commandLink>
            <rich:toolTip for="export_excel_link">
                <span style="white-space:nowrap">
                    Click to export to excel.
                </span>
            </rich:toolTip>

        </h:panelGrid>

        <h:panelGrid width="100%" style="margin-right:auto; margin-left:auto;">
            <a4j:region>
                <rich:dataTable id="usersTable" width="100%"  value="#{alpha.listAlphas}" var="alpha" rows="10" ajaxKeys="#{alpha.username}" style="text-align:left" styleClass="table table-striped">
                    <rich:column sortable="true" sortBy="#{alpha.username}">
                        <f:facet name="header"><h:outputText value="Username"/></f:facet>
                        <h:outputText value="#{alpha.username}"/>
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{alpha.name}">
                        <f:facet name="header"><h:outputText value="Alphanumeric"/></f:facet>
                        <h:outputText value="#{alpha.name}"/>
                    </rich:column>

                    <rich:column>
                        <f:facet name="header"><h:outputText value="Action"/></f:facet>


                        <a4j:commandLink ajaxSingle="true" id="alphalink"
                                         oncomplete="#{rich:component('alphaPanel')}.show()">

                            <h:graphicImage value="/resources/images/icons/edit.gif" style="border:0" >

                            </h:graphicImage>
                            <f:setPropertyActionListener value="#{alpha}"
                                                         target="#{userScrollerBean.currentAlpha}" />

                        </a4j:commandLink>
                        <rich:toolTip for="alphalink">
                            <span style="white-space:nowrap">
                                Click to view and edit user alphanumerics
                            </span>
                        </rich:toolTip>
                        <rich:spacer width="3"/>
                        <a4j:commandLink ajaxSingle="true" id="delete_alphalink"
                                         oncomplete="#{rich:component('deleteAlphaPanel')}.show()">

                            <h:graphicImage value="/resources/images/icons/delete.gif" style="border:0" >

                            </h:graphicImage>
                            <f:setPropertyActionListener value="#{alpha}"
                                                         target="#{userScrollerBean.currentAlpha}" />

                        </a4j:commandLink>
                        <rich:toolTip for="delete_alphalink">
                            <span style="white-space:nowrap">
                                Click to delete Alphanumeric
                            </span>
                        </rich:toolTip>
                        <rich:spacer width="3"/>


                    </rich:column>

                    <f:facet name="footer">
                        <rich:datascroller selectedStyle="font-weight:bold"/>
                    </f:facet>
                </rich:dataTable>
            </a4j:region>
        </h:panelGrid>

    </h:form>


    <rich:modalPanel id="alphaPanel" autosized="true" width="450">
        <f:facet name="header">
            <h:outputText value="Edit user Alphanumerics" />
        </f:facet>
        <f:facet name="controls">
            <h:panelGroup>
                <a4j:form>
                    <a4j:commandLink>
                        <h:graphicImage value="/resources/images/icons/close.png" id="hidelink1"
                                        styleClass="hidelink" />
                    </a4j:commandLink>

                </a4j:form>
            </h:panelGroup>
        </f:facet>
        <h:form>
            <rich:messages style="color:red;"></rich:messages>
            <h:panelGrid columns="1">
                <a4j:outputPanel ajaxRendered="true">
                    <jsp:include page="editAlpha.jsp"/>
                    <rich:message showSummary="true" showDetail="false" for="price" />
                </a4j:outputPanel>
                <a4j:commandButton value="Update"
                                   action="#{userScrollerBean.currentAlpha.saveOrUpdateAlpha}"
                                   reRender="updateMessage"
                                   oncomplete="if (#{facesContext.maximumSeverity==null}) #{rich:component('alphaPanel')}.hide();" />
            </h:panelGrid>
        </h:form>
    </rich:modalPanel>
    <rich:modalPanel id="deleteAlphaPanel" autosized="true" width="450">
        <f:facet name="header">
            <h:outputText value="Delete Alphanumeric" />
        </f:facet>
        <f:facet name="controls">
            <h:panelGroup>
                <a4j:form>
                    <a4j:commandLink>
                        <h:graphicImage value="/resources/images/icons/close.png" id="hidelink_delete_alpha"
                                        styleClass="hidelink" />
                    </a4j:commandLink>

                </a4j:form>
            </h:panelGroup>
        </f:facet>
        <h:form>
            <rich:messages style="color:red;"></rich:messages>
            <h:panelGrid columns="1">
                <a4j:outputPanel ajaxRendered="true">

                    <h:outputText value=""></h:outputText>
                    <h:inputHidden id="org_username" value="#{userScrollerBean.currentAlpha.username}">

                    </h:inputHidden>
                    <h:outputLabel value="Are you sure you want to delete Alphanumeric? Note: You cannot undo."/>
                </a4j:outputPanel>
                <h:panelGrid  columns="2" style="margin-right:auto; margin-left:auto; text-align:center" width="100%">
                    <a4j:commandButton value="Delete"
                                       action="#{userScrollerBean.currentAlpha.deleteAlphanumeric}"
                                       reRender="updateMessage"
                                       oncomplete="if (#{facesContext.maximumSeverity==null}) #{rich:component('deleteAlphaPanel')}.hide();" />
                    <a4j:commandButton value="Cancel" onclick="if (#{facesContext.maximumSeverity==null}) #{rich:component('deleteAlphaPanel')}.hide();" />
                </h:panelGrid>
            </h:panelGrid>
        </h:form>
    </rich:modalPanel>

</rich:panel>

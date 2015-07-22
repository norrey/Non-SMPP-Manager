
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>


<rich:panel  style="margin-right:auto; margin-left:auto;" rendered="#{userScrollerBean.currentUser.message ne null}">
    <h:outputLabel  value="#{userScrollerBean.currentUser.message}" id="updateMessage" styleClass="success"/>
</rich:panel>

<rich:panel style="margin-left:auto; margin-right:auto" header="AVAILABLE USERS">
    <h:form>
        <h:panelGrid width="100%" style="margin-left:auto; margin-right:auto; text-align:right">
            <h:panelGroup>
                <h:commandLink action="#{user.generateXSL()}" id="export_excel_link1" >

                <h:graphicImage value="/resources/images/icons/icon-xls.gif" style="border:0" >
                </h:graphicImage>
            </h:commandLink>
            <rich:toolTip for="export_excel_link1">
                <span style="white-space:nowrap">
                    Click to export to excel.
                </span>
            </rich:toolTip>
                <rich:spacer width="3"/>
            <h:commandLink  action="#{user.generatePDF()}" id="export_to_pdf_link">

                <h:graphicImage value="/resources/images/icons/pdficon.png" style="border:0" >
                </h:graphicImage>
            </h:commandLink>
            <rich:toolTip for="export_to_pdf_link">
                <span style="white-space:nowrap">
                    Click to export to Pdf.
                </span>
            </rich:toolTip>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid width="100%" style="margin-left:auto; margin-right:auto;">
            <a4j:region>
                <rich:dataTable id="usersTable" width="100%"  value="#{user.listUsers}" var="user" rows="10" ajaxKeys="#{user.username}" style="text-align:left" styleClass="table table-striped">
                    <rich:column sortable="true" sortBy="#{user.username}">
                        <f:facet name="header"><h:outputText value="Username"/></f:facet>
                        <h:outputText value="#{user.username}"/>
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{user.smsCredits}">
                        <f:facet name="header"><h:outputText value="SMS Credits"/></f:facet>
                        <h:outputText value="#{user.smsCredits}"/>
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{user.organization}">
                        <f:facet name="header"><h:outputText value="Organization"/></f:facet>
                        <h:outputText value="#{user.organization}"/>
                    </rich:column>
                    <rich:column>
                        <f:facet name="header"><h:outputText value="Mobile"/></f:facet>
                        <h:outputText value="#{user.userMobile}"/>
                    </rich:column>
                    <rich:column>
                        <f:facet name="header"><h:outputText value="Email"/></f:facet>
                        <h:outputText value="#{user.userEmail}"/>
                    </rich:column>
                    <rich:column>
                        <f:facet name="header"><h:outputText value="Action"/></f:facet>

                        <a4j:commandLink ajaxSingle="true" id="editlink"
                                         oncomplete="#{rich:component('editPanel')}.show()">
                            <h:graphicImage value="/resources/images/icons/edit.gif" style="border:0" />
                            <f:setPropertyActionListener value="#{user}"
                                                         target="#{userScrollerBean.currentUser}" />
                        </a4j:commandLink> 
                        <rich:toolTip for="editlink">
                            <span style="white-space:nowrap">
                                Click to view and edit user details.
                            </span>
                        </rich:toolTip>

                        <rich:spacer width="3"/>

                        <a4j:commandLink ajaxSingle="true" id="alphalink"
                                         oncomplete="#{rich:component('alphaPanel')}.show()">

                            <h:graphicImage value="/resources/images/icons/alpha.gif" style="border:0" >

                            </h:graphicImage>
                            <f:setPropertyActionListener value="#{user}"
                                                         target="#{userScrollerBean.currentUser}" />

                        </a4j:commandLink>
                        <rich:toolTip for="alphalink">
                            <span style="white-space:nowrap">
                                Click to view and edit user alphanumerics
                            </span>
                        </rich:toolTip>
                        <rich:spacer width="3"/>

                        <a4j:commandLink ajaxSingle="true" id="editCreditLink"
                                         oncomplete="#{rich:component('creditPanel')}.show()">

                            <h:graphicImage value="/resources/images/icons/sms.png" style="border:0" >

                            </h:graphicImage>
                            <f:setPropertyActionListener value="#{user}"
                                                         target="#{userScrollerBean.currentUser}" />

                        </a4j:commandLink>
                        <rich:toolTip for="editCreditLink">
                            <span style="white-space:nowrap">
                                Click to manage SMS Credits
                            </span>
                        </rich:toolTip>

                    </rich:column>

                    <f:facet name="footer">
                        <rich:datascroller selectedStyle="font-weight:bold"/>
                    </f:facet>
                </rich:dataTable>
            </a4j:region>
        </h:panelGrid>

    </h:form>
    <rich:modalPanel id="editPanel" autosized="true" width="450">
        <f:facet name="header">
            <h:outputText value="Edit Current User" />
        </f:facet>
        <f:facet name="controls">
            <h:panelGroup>
                <a4j:form>
                    <a4j:commandLink>
                        <h:graphicImage value="/resources/images/icons/close.png" id="hidelink"
                                        styleClass="hidelink" />
                    </a4j:commandLink>

                </a4j:form>
            </h:panelGroup>
        </f:facet>
        <h:form>
            <rich:messages style="color:red;"></rich:messages>
            <h:panelGrid columns="1">
                <a4j:outputPanel ajaxRendered="true">
                    <jsp:include page="editUser.jsp"/>
                    <rich:message showSummary="true" showDetail="false" for="price" />
                </a4j:outputPanel>
                <a4j:commandButton value="Update"
                                   action="#{userScrollerBean.currentUser.updateUser}"
                                   reRender="updateMessage"
                                   oncomplete="if (#{facesContext.maximumSeverity==null}) #{rich:component('editPanel')}.hide();" />
            </h:panelGrid>
        </h:form>
    </rich:modalPanel>

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
                    <jsp:include page="addAlpha.jsp"/>
                    <rich:message showSummary="true" showDetail="false" for="price" />
                </a4j:outputPanel>
                <a4j:commandButton value="Update"
                                   action="#{userScrollerBean.currentUser.saveOrUpdateAlpha}"
                                   reRender="updateMessage"
                                   oncomplete="if (#{facesContext.maximumSeverity==null}) #{rich:component('alphaPanel')}.hide();" />
            </h:panelGrid>
        </h:form>
    </rich:modalPanel>

    <rich:modalPanel id="creditPanel" autosized="true" width="450">
        <f:facet name="header">
            <h:outputText value="Manage SMS Credits" />
        </f:facet>
        <f:facet name="controls">
            <h:panelGroup>
                <a4j:form>
                    <a4j:commandLink>
                        <h:graphicImage value="/resources/images/icons/close.png" id="hidelink3"
                                        styleClass="hidelink" />
                    </a4j:commandLink>

                </a4j:form>
            </h:panelGroup>
        </f:facet>
        <a4j:form ajaxSingle="true" ajaxSubmit="true" reRender="smsCredit">
            <rich:messages style="color:red;"></rich:messages>
            <h:panelGrid columns="1" width="100%" style="margin-right:auto; margin-left:auto;">
                <a4j:outputPanel ajaxRendered="true">
                    <jsp:include page="manageSMSCredit.jsp"/>

                </a4j:outputPanel>

            </h:panelGrid>
        </a4j:form>

    </rich:modalPanel>

</rich:panel>

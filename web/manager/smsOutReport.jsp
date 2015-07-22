
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>




<rich:panel style="margin-left:auto; margin-right:auto" header="SMS OUT REPORT">
    <a4j:keepAlive beanName="sMSOut"/>
    <h:form>
        <h:panelGrid columns="8" width="100%" style="margin-left:auto; margin-right:auto;padding:8px">
            <h:outputText value="Start Date :"/>
            <rich:calendar value="#{sMSOut.reportStartDate}"
                           cellWidth="24px" cellHeight="22px" style="width:200px" datePattern="yyyy-MM-dd"/>
            <h:outputText value="End Date :"/>
            <rich:calendar value="#{sMSOut.reportEndDate}"
                           cellWidth="24px" cellHeight="22px" style="width:200px" datePattern="yyyy-MM-dd"/>
            <h:outputText value="User :"/>
            <rich:comboBox value="#{sMSOut.user}" defaultLabel="Select User" suggestionValues="#{sMSOut.usernames}" directInputSuggestions="true"/>
            <h:panelGroup layout="block" rendered="#{sMSOut.reportStartDate ne null and sMSOut.reportEndDate ne null}">
                <a4j:commandLink id="report_gen" action="#{sMSOut.smsOutReport()}" reRender="smsout_report_grid">
                    <h:graphicImage value="/resources/images/icons/report.png" id="generate_report"
                                    />
                </a4j:commandLink>
                <rich:toolTip for="report_gen">
                    <span style="white-space:nowrap">
                        Click to generate report
                    </span>
                </rich:toolTip>
            </h:panelGroup>
            <h:panelGroup layout="block" rendered="#{sMSOut.reportStartDate ne null and sMSOut.reportEndDate ne null}">

                <h:commandLink id="xlsx_gen" action="#{sMSOut.generateXLSX()}">
                    <h:graphicImage value="/resources/images/icons/icon-xls.gif" id="export_to_xlsx"
                                    />
                </h:commandLink>
                <rich:toolTip for="xlsx_gen">
                    <span style="white-space:nowrap">
                        Click to export report to excel
                    </span>
                </rich:toolTip>
            </h:panelGroup>
        </h:panelGrid>
    </h:form>
    <h:form>

        <h:panelGrid id="smsout_report_grid" style="margin-left:auto; margin-right:auto;" width="100%" rendered="#{sMSOut.user ne null}">
            <a4j:region>
                <rich:dataTable id="sms_report_table" width="100%"  value="#{sMSOut.smsOutReport()}" rows="10" var="smsOut" ajaxKeys="#{sMSOut.id}" style="text-align:left" styleClass="table table-striped">
                    <rich:column sortable="true" sortBy="#{smsOut.destinationAddr}">
                        <f:facet name="header"><h:outputText value="Mobile"/></f:facet>
                        <h:outputText value="#{smsOut.destinationAddr}"/>
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{smsOut.sourceAddr}">
                        <f:facet name="header"><h:outputText value="Source Address"/></f:facet>
                        <h:outputText value="#{smsOut.sourceAddr}"/>
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{smsOut.messagePayload}">
                        <f:facet name="header"><h:outputText value="Message"/></f:facet>
                        <h:outputText value="#{smsOut.messagePayload}"/>
                        
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{smsOut.timeSubmitted}">
                        <f:facet name="header"><h:outputText value="Time Sent"/></f:facet>
                        <h:outputText value="#{smsOut.displayTimeSubmitted}"/>
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{smsOut.timeProcessed}">
                        <f:facet name="header"><h:outputText value="Last Update"/></f:facet>
                        <h:outputText value="#{smsOut.displayTimeProcessed}"/>
                    </rich:column>
                    
                    <rich:column sortable="true" sortBy="#{smsOut.user}">
                        <f:facet name="header"><h:outputText value="User"/></f:facet>
                        <h:outputText value="#{smsOut.user}"/>
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{smsOut.realStatus}">
                        <f:facet name="header"><h:outputText value="Status"/></f:facet>
                        <h:outputText value="#{smsOut.realStatus}"/>
                    </rich:column>
                    <rich:column sortable="true" sortBy="#{smsOut.smsCount}">
                        <f:facet name="header"><h:outputText value="No. of SMS"/></f:facet>
                        <h:outputText value="#{smsOut.smsCount}"/>
                    </rich:column>



                    <f:facet name="footer">
                        <rich:columnGroup>
                            <rich:column colspan="7">Summary: Total Number of SMS Sent for the period</rich:column>
                            <rich:column><h:outputLabel value="#{sMSOut.totaSMS}"/></rich:column>
                        </rich:columnGroup>
                    </f:facet>
                </rich:dataTable>
                <rich:datascroller for="sms_report_table"/>
            </a4j:region>
        </h:panelGrid>

    </h:form>
    <rich:modalPanel id="editPanel" autosized="true" width="450">
        <f:facet name="header">
            <h:outputText value="Edit Current User" />
        </f:facet>
        <f:facet name="controls">
            <h:panelGroup>
                <h:graphicImage value="/resources/images/icons/close.png" id="hidelink"
                                styleClass="hidelink" />
                <rich:componentControl for="editPanel" attachTo="hidelink"
                                       operation="hide" event="onclick" />
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
                <h:graphicImage value="/resources/images/icons/close.png" id="hidelink1"
                                styleClass="hidelink" />
                <rich:componentControl for="alphaPanel" attachTo="hidelink1"
                                       operation="hide" event="onclick" />
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
                <h:graphicImage value="/resources/images/icons/close.png" id="hidelink3"
                                styleClass="hidelink" />
                <rich:componentControl for="creditPanel" attachTo="hidelink3"
                                       operation="hide" event="onclick" />
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

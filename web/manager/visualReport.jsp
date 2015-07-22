
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>




<rich:panel style="margin-left:auto; margin-right:auto" header="SMS OUT VISUAL REPORT">
    <a4j:keepAlive beanName="sMSOut"/>
    <h:form>
        <h:panelGrid columns="7" width="100%" style="margin-left:auto; margin-right:auto;padding:8px">
            <h:outputText value="Start Date :"/>
            <rich:calendar value="#{sMSOut.reportStartDate}"
                           cellWidth="24px" cellHeight="22px" style="width:200px" datePattern="yyyy-MM-dd"/>
            <h:outputText value="End Date :"/>
            <rich:calendar value="#{sMSOut.reportEndDate}"
                           cellWidth="24px" cellHeight="22px" style="width:200px" datePattern="yyyy-MM-dd"/>
            <h:outputText value="User :"/>
            <rich:comboBox value="#{sMSOut.user}" defaultLabel="Select User" suggestionValues="#{sMSOut.usernames}" directInputSuggestions="true"/>
            <h:panelGroup layout="block" rendered="#{sMSOut.reportStartDate ne null and sMSOut.reportEndDate ne null}">
                <a4j:commandLink id="report_gen" action="#{sMSOut.smsOutReport()}" reRender="visual_report_grid" oncomplete="drawChart('#{sMSOut.smsOutReport2()}')">
                    <h:graphicImage value="/resources/images/icons/report.png" id="generate_report"
                                    />
                </a4j:commandLink>
                <rich:toolTip for="report_gen">
                    <span style="white-space:nowrap">
                        Click to generate report
                    </span>
                </rich:toolTip>
            </h:panelGroup>
            
        </h:panelGrid>
    </h:form>
    <h:panelGrid id="visual_report_grid" style="margin-right:auto; margin-left:auto;" width="100%">
        <h:panelGroup style="width: 100%;" layout="block">
            <div id="chart_div"></div>
        </h:panelGroup>
        <h:panelGroup style="width: 100%;" layout="block">
            <div id="chart1_div"></div>
        </h:panelGroup>
    </h:panelGrid>

</rich:panel>

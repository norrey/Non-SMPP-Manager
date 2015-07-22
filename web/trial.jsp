<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>
<f:view>
    <a4j:region id="theRegion">
        <html>

            <head>

            </head>
            <rich:panel>
                <f:facet name="header">
                    <h:outputText value="Ajax In action"/>
                </f:facet>
                <h2>AJAX</h2>
                <button type="button" onclick="echoData()">Request data</button>
                <div id="myDiv"></div>
            </rich:panel>

            <rich:panel>

                <h:form>
                    <h:outputLabel value="#{sMSOut.smsOutReport2()}" id="output"/>
                    <h:panelGrid columns="8" width="100%" style="margin-left:auto; margin-right:auto;padding:8px">
                        <h:outputText value="Start Date :"/>
                        <rich:calendar value="#{sMSOut.reportStartDate}"
                                       cellWidth="24px" cellHeight="22px" style="width:200px"/>
                        <h:outputText value="End Date :"/>
                        <rich:calendar value="#{sMSOut.reportEndDate}"
                                       cellWidth="24px" cellHeight="22px" style="width:200px"/>
                        <h:outputText value="User :"/>
                        <rich:comboBox value="#{sMSOut.user}" defaultLabel="Select User" suggestionValues="#{sMSOut.usernames}" directInputSuggestions="true"/>
                        <h:panelGroup layout="block" rendered="#{sMSOut.reportStartDate ne null and sMSOut.reportEndDate ne null}">
                            <a4j:commandLink id="report_gen" action="#{sMSOut.smsOutReport2()}" reRender="output" oncomplete="initializeVariable('#{sMSOut.smsOutReport2()}')">
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

            </rich:panel>
            <h:form>
                <rich:panel bodyClass="rich-laguna-panel-no-header">
                    <a4j:commandButton value="Set Name to Alex"  reRender="rep" >
                        <a4j:actionparam name="username" value="Norrey Osako" assignTo="#{authenticationBean.username}"/>
                    </a4j:commandButton>
                    <rich:spacer width="20" />
                    <a4j:commandButton value="Set Name to John"  reRender="rep" >
                        <a4j:actionparam name="username" value="Christine Boyani" assignTo="#{authenticationBean.username}"/>
                    </a4j:commandButton>
                </rich:panel>
                <rich:spacer height="1" />
                <rich:panel bodyClass="rich-laguna-panel-no-header">
                    <h:outputText id="rep" value="Selected Name:#{authenticationBean.username}"/>
                </rich:panel>
            </h:form>
            <a4j:outputPanel ajaxRendered="true" id="re">
                <h:message for="rep"/>
                <h:outputText value="#{authenticationBean.username}"/>
            </a4j:outputPanel>
            <rich:spacer height="50px"/>
            <rich:panel>
                <h:form>
                    <h:outputText value="Name : "/>
                    <h:inputSecret value="#{authenticationBean.password}">

                    </h:inputSecret>
                    <h:commandButton value="Submit">
                        <a4j:support disableDefault="true" event="onkeyup" reRender="password"></a4j:support>
                    </h:commandButton>

                    <h:outputText id="password" value="#{authenticationBean.password}"/>
                </h:form>
            </rich:panel>

            <rich:spacer height="50px"/>
            <rich:panel>
                <a4j:form ajaxSubmit="true" reRender="password1">
                    <h:outputText value="Name : "/>
                    <h:inputSecret value="#{authenticationBean.password}">

                    </h:inputSecret>
                    <a4j:commandButton value="Submit" reRender="passsword1">

                    </a4j:commandButton>

                    <h:outputText id="password1" value="#{authenticationBean.password}"/>
                </a4j:form>
            </rich:panel>

            <rich:panel>
                <h:panelGrid columns="3">
                    <h:outputLabel for="myTextArea" value="Input Text"/>
                    <h:inputTextarea id="myTextArea" cols="60" rows="15"/>

                    <h:form>
                        <h:panelGrid columns="2" columnClasses="top,top">
                            <rich:fileUpload fileUploadListener="#{fileUploadBean.listener}"
                                             maxFilesQuantity="#{fileUploadBean.uploadsAvailable}"
                                             id="upload"
                                             immediateUpload="#{fileUploadBean.autoUpload}"
                                             acceptedTypes="jpg, gif, png, bmp" allowFlash="#{fileUploadBean.useFlash}">
                                <a4j:support event="onuploadcomplete" reRender="info" />
                            </rich:fileUpload>
                            <h:panelGroup id="info">
                                <rich:panel bodyClass="info">
                                    <f:facet name="header">
                                        <h:outputText value="Uploaded Files Info" />
                                    </f:facet>
                                    <h:outputText value="No files currently uploaded"
                                                  rendered="#{fileUploadBean.size==0}" />
                                    <rich:dataGrid columns="1" value="#{fileUploadBean.files}"
                                                   var="file" rowKeyVar="row">
                                        <rich:panel bodyClass="rich-laguna-panel-no-header">
                                            <h:panelGrid columns="2">
                                                <a4j:mediaOutput element="img" mimeType="#{file.mime}"
                                                                 createContent="#{fileUploadBean.paint}" value="#{row}"
                                                                 style="width:100px; height:100px;" cacheable="false">
                                                    <f:param value="#{fileUploadBean.timeStamp}" name="time"/>  
                                                </a4j:mediaOutput>
                                                <h:panelGrid columns="2">
                                                    <h:outputText value="File Name:" />
                                                    <h:outputText value="#{file.name}" />
                                                    <h:outputText value="File Length(bytes):" />
                                                    <h:outputText value="#{file.length}" />
                                                </h:panelGrid>
                                            </h:panelGrid>
                                        </rich:panel>
                                    </rich:dataGrid>
                                </rich:panel>
                                <rich:spacer height="3"/>
                                <br />
                                <a4j:commandButton action="#{fileUploadBean.clearUploadData}"
                                                   reRender="info, upload" value="Clear Uploaded Data"
                                                   rendered="#{fileUploadBean.size>0}" />
                            </h:panelGroup>
                        </h:panelGrid>
                    </h:form>
                </h:panelGrid>
            </rich:panel>

            <rich:panel>
                <f:facet name="header">
                    <h:outputText value="Collapsible Panel"/>
                </f:facet>


                <rich:simpleTogglePanel switchType="client" label="This is a simple toggle panel">
                    The framework is implemented by using a component library. The library
                    set Ajax functionality into existing pages, so there is no need to write
                    any JavaScript code or to replace existing components with new Ajax one. 
                    Ajax4jsf enables page-wide Ajax support instead of the traditional 
                    component-wide support and it gives the opportunity to define the event 
                    on the page. An event invokes an Ajax request and areas of the page 
                    which are synchronized with the JSF Component Tree after changing the 
                    data on the server by Ajax request in accordance with events fired on 
                    the client.             
                </rich:simpleTogglePanel>   
                <rich:simpleTogglePanel switchType="client" label="This is another simple toggle panel">
                    We are going to be the best coders around. And I am not joking around.            
                </rich:simpleTogglePanel>
                <rich:simpleTogglePanel switchType="client" label="This is a third simple toggle panel">
                    We are going to be the best coders around. And I am not joking around.            
                </rich:simpleTogglePanel>


            </rich:panel>


            <rich:panel>
                <div style="width: 600px;">
                    <div id="chart_div"></div>
                </div>
                <div style="width: 600px;">
                    <div id="chart1_div"></div>
                </div>
                <div style="width: 600px;">
                    <div id="chart2_div"></div>
                </div>
            </rich:panel>

            <script type="text/javascript" src="https://www.google.com/jsapi"></script>
            <script type="text/javascript">

                    Array.prototype.reduce = undefined;
                    // Load the Visualization API and the piechart package.
                    google.load('visualization', '1.0', {
                        'packages': ['corechart']
                    });


                    var serverData1 = '<h:outputText value="#{sMSOut.smsOutReport2()}"/>';

                    initializeVariable(serverData1);
                    
                    function initializeVariable(serverData) {

                        
                        var rows = JSON.parse('[' + serverData + ']');
                        var data = new google.visualization.DataTable();
                        
                        data.addColumn('string', 'Year Month');
                        data.addColumn('number', 'No. of Times Sent');
                        data.addRows(rows);
                        // Set chart options
                        var options = {
                            'title': 'No of SMS Sent for User',
                            is3D: true,
                            pieSliceText: 'label',
                            tooltip: {
                                showColorCode: true
                            },
                            'width': 900,
                            'height': 500
                        };
                        // Instantiate and draw our chart, passing in some options.
                        //PieChart
                        //LineChart
                        //BarChart
                        var chart = new google.visualization.BarChart(document
                                .getElementById('chart_div'));
                        chart.draw(data, options);
                        var chart = new google.visualization.LineChart(document
                                .getElementById('chart1_div'));
                        chart.draw(data, options);
                        

                    }


            </script>

        </html>
        <h:outputText value="Read More" style="color:blue;" id="more_text"/>
                        <rich:toolTip for="more_text">
                            <span style="white-space:nowrap">
                                <h:outputText value="#{smsOut.messagePayload}"/>
                            </span>
                        </rich:toolTip>
    </a4j:region>
</f:view>
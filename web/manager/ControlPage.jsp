<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>



<f:view>

    <html>
        <head>


            <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
            <title>MSpace: Main Panel</title> 

            <link rel="stylesheet" href="resources/bootstrap/css/bootstrap.min.css">

            <script type="text/javascript" src="https://www.google.com/jsapi"></script>
            <script type="text/javascript">

                Array.prototype.reduce = undefined;
                // Load the Visualization API and the piechart package.
                google.load('visualization', '1.0', {
                    'packages': ['corechart']
                });


                function drawChart(serverData) {


                    var rows = JSON.parse('[' + serverData + ']');
                    var data = new google.visualization.DataTable();

                    data.addColumn('string', 'Year Month');
                    data.addColumn('number', 'No. of Times Sent');
                    data.addRows(rows);
                    // Set chart options
                    var options = {
                        'title': 'No of SMS Sent',
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
                    var chart = new google.visualization.LineChart(document
                            .getElementById('chart_div'));
                    chart.draw(data, options);
                    var chart = new google.visualization.BarChart(document
                            .getElementById('chart1_div'));
                    chart.draw(data, options);


                }

                function drawChartAll(serverData, users) {


                    var rows = JSON.parse('[' + serverData + ']');
                    var usernames = JSON.parse(users);
                    var index;
                    
                    var data = new google.visualization.DataTable();
                    
                    data.addColumn('string', 'Timeline');
                    for (index = 0; index < usernames.length; index++){

                        data.addColumn('number', usernames[index]);
                        
                    }

                    data.addRows(rows);
                    // Set chart options
                    var options = {
                        'title': 'No of SMS Sent',
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
                    var chart = new google.visualization.LineChart(document
                            .getElementById('chart_div'));
                    chart.draw(data, options);
                    var chart = new google.visualization.BarChart(document
                            .getElementById('chart1_div'));
                    chart.draw(data, options);


                }


            </script>

            <style>
                .one{width: 40%; border: none ; text-align: right; padding: 8px}
                .two{width: 25%; border: none ; text-align: left}
                .three{width: 35%; border: none ; text-align: left}
                .reportTableCol1{width: 50%; border: 1px solid ; text-align: right; padding: 8px}
                .reportTableCol2{width: 50%; border: 1px solid ; text-align: left; padding: 8px}
                .manageSMSCol1{width: 50%; border: none ; text-align: right; padding: 3px}
                .manageSMSCol2{width: 50%; border: none ; text-align: left; padding: 3px}

                .info, .success, .warning, .error, .validation {
                    border: 1px solid;
                    width: 100%;
                    padding:15px 10px 15px 50px;
                    background-repeat: no-repeat;
                    background-position: 10px center;
                    margin-left: auto;
                    margin-right: auto;
                }
                .info {
                    color: #00529B;
                    background-color: #BDE5F8;
                    background-image: url('resources/images/icons/info.png');
                }
                .success {
                    color: #4F8A10;
                    background-color: #DFF2BF;
                    background-image:url('resources/images/icons/success.png');
                }
                .warning {
                    color: #9F6000;
                    background-color: #FEEFB3;
                    background-image: url('resources/images/icons/warning.png');
                }
                .error {
                    color: #D8000C;
                    background-color: #FFBABA;
                    background-image: url('resources/images/icons/error.png');
                }
            </style>



        </head>
        <body>

            <!-- header -->
            <div id="eaders" >
                <div align="center"><img src="resources/images/logo.gif" alt="mspace" border="0" longdesc="http://www.mspace.co.ke" /></div>
            </div>
            <rich:spacer height="20"/>
            <table height="70%"  width="100%" border="0" >
                <tr>
                    <td valign="top" align="center" width="20%" >
                        <a4j:region id="menu">
                        <h:form id="formmenu">
                            <h:panelGrid width="100%">
                                <rich:panelMenu  mode="ajax"
                                                 iconExpandedGroup="disc" iconCollapsedGroup="disc"
                                                 iconExpandedTopGroup="chevronUp" iconGroupTopPosition="right"
                                                 iconCollapsedTopGroup="chevronDown">

                                    <rich:panelMenuGroup label="Manage User Details" style="text-align:left;">
                                        <rich:panelMenuItem reRender="pages" id="addUserItem">
                                            <h:outputText value="Add User"/>
                                            <f:setPropertyActionListener target="#{panelMenuBean.currentPage}" value="/manager/newUser.jsp"/>
                                        </rich:panelMenuItem>
                                        <rich:toolTip for="addUserItem">
                                            <span style="white-space:nowrap">
                                                Click to add new users
                                            </span>
                                        </rich:toolTip>

                                        <rich:panelMenuItem reRender="pages" id="viewUsersItem">
                                            <h:outputText value="View Users"/>
                                            <f:setPropertyActionListener target="#{panelMenuBean.currentPage}" value="/manager/showUsers.jsp"/>

                                        </rich:panelMenuItem>
                                        <rich:toolTip for="viewUsersItem">
                                            <span style="white-space:nowrap">
                                                Click to view available users
                                            </span>
                                        </rich:toolTip>

                                        <rich:panelMenuItem reRender="pages" id="view_alphanumerics">
                                            <h:outputText value="View Alphanumerics"/>
                                            <f:setPropertyActionListener target="#{panelMenuBean.currentPage}" value="/manager/manageAlphanumerics.jsp"/>

                                        </rich:panelMenuItem>
                                        <rich:toolTip for="view_alphanumerics">
                                            <span style="white-space:nowrap">
                                                Click to view and manage user alphanumerics
                                            </span>
                                        </rich:toolTip>

                                    </rich:panelMenuGroup>
                                    <rich:panelMenuGroup label="Summary and Reports" style="text-align:left;">
                                        <rich:panelMenuItem reRender="pages" id="report">
                                            <h:outputText value="Simple Statistics"/>
                                            <f:setPropertyActionListener target="#{panelMenuBean.currentPage}" value="/manager/simpleStatistics.jsp"/>
                                        </rich:panelMenuItem>
                                        <rich:toolTip for="report">
                                            <span style="white-space:nowrap">
                                                Click to view Simple Statistics
                                            </span>
                                        </rich:toolTip>

                                        <rich:panelMenuItem reRender="pages" id="report2">
                                            <h:outputText value="SMS Out Report"/>
                                            <f:setPropertyActionListener target="#{panelMenuBean.currentPage}" value="/manager/smsOutReport.jsp"/>

                                        </rich:panelMenuItem>
                                        <rich:toolTip for="report2">
                                            <span style="white-space:nowrap">
                                                Click to view report
                                            </span>
                                        </rich:toolTip>
                                        <rich:panelMenuItem reRender="pages" id="visual_report">
                                            <h:outputText value="Single User Visual Report"/>
                                            <f:setPropertyActionListener target="#{panelMenuBean.currentPage}" value="/manager/visualReport.jsp"/>

                                        </rich:panelMenuItem>
                                        <rich:toolTip for="visual_report">
                                            <span style="white-space:nowrap">
                                                Click to analyze user data visually
                                            </span>
                                        </rich:toolTip>
                                        <rich:panelMenuItem reRender="pages" id="visual_report_all_users">
                                            <h:outputText value="All Users Visual Report"/>
                                            <f:setPropertyActionListener target="#{panelMenuBean.currentPage}" value="/manager/compareVisualReport.jsp"/>

                                        </rich:panelMenuItem>
                                        <rich:toolTip for="visual_report_all_users">
                                            <span style="white-space:nowrap">
                                                Click to compare users visually
                                            </span>
                                        </rich:toolTip>

                                    </rich:panelMenuGroup>

                                    <rich:panelMenuItem  action="#{authenticationBean.logout}" id="logoutItem">
                                        <h:outputText style="padding:5px;background-color:#F0F0F0;color:#FF0000 ;" value="Log Out"/>
                                        <f:setPropertyActionListener value="/index.jsp" target="#{authenticationBean.logout}"/>
                                    </rich:panelMenuItem>
                                    <rich:toolTip for="logoutItem">
                                        <span style="white-space:nowrap">
                                            Click to logout of the SMPP application
                                        </span>
                                    </rich:toolTip>

                                </rich:panelMenu>

                            </h:panelGrid>
                        </h:form>
                               </a4j:region>


                    </td>
                    <td valign="top" align="center" width="80%" height="50%">
                        <!----------------------------------------------------------------------------------------------------------------------->

                        <a4j:outputPanel id="pages" ajaxRendered="true">


                            <h:panelGroup >
                                <a4j:include viewId="#{panelMenuBean.currentPage}"/>
                            </h:panelGroup>



                        </a4j:outputPanel>
                        
                        <a4j:status for="menu" onstart="#{rich:component('processing')}.show()" onstop="#{rich:component('processing')}.hide()"/>

                        <rich:modalPanel style="text-align:center" id="processing" autosized="true" width="200" height="60" moveable="false" resizeable="false">
                            
                            <h:graphicImage value="resources/images/icons/loading.gif"/>
                        </rich:modalPanel>





                        <!----------------------------------------------------------------------------------------------------------------------->     

                    </td>
                </tr>
            </table>
            <rich:spacer height="50"></rich:spacer>
                <div style="position: fixed; left:0px; right:0px; bottom: 0px; width: 100%; height: 34px; background-color: white; alignment-adjust: central; text-align: center; background-color: #C2C2A3;">

                    <p>
                        &copy; <h:outputLabel value="#{copyrightYear.year}"/> <a href="http://www.mspace.co.ke"><strong>MSpace Solutions Ltd.</strong></a><strong> </strong>&nbsp;&nbsp;</p>

            </div>

        </body>
    </html>
</f:view>

<%--
    Document   : login
    Created on : Oct 6, 2010, 11:19:15 AM
    Author     : Davis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>

<f:view>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>


            <style type="text/css">
                .rich-message-marker img {
                    padding-right:7px;
                }
                .rich-message-label {
                    color:red;
                }
                div#wrap{
                    text-align: center;
                }
                div.footer{
                    text-align: center;
                    background-color: #C2C2A3;
                }
                .info, .success, .warning, .error, .validation {
                    border: 1px solid;
                    width: 55%;
                    padding:10px 10px 10px 50px;
                    background-repeat: no-repeat;
                    background-position: 10px center;
                    margin-left: auto;
                    margin-right: auto;
                    top: 100px;
                    left:20%;
                    right: 25%;
                    position: fixed;
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

            <title>MSpace | Login</title></head>

    </head>
    <body>
        <!-- wrap starts here -->
        <div id="wrap">

            <!-- header -->
            <div id="eaders" >
                <div align="center"><img src="resources/images/logo.gif" alt="mspace" border="0" longdesc="http://www.mspace.co.ke" /></div>
            </div>

            <div id="sidebar" >

                <div class="left-box">

                </div>

            </div>


            <div id="main">
                <center>

                    <rich:spacer height="100px"/>

                    <h:outputLabel rendered="#{authenticationBean.message ne null}"  value="#{authenticationBean.message}" id="output" styleClass="success"/>
                    <h:outputLabel rendered="#{authenticationBean.error ne null}"  value="#{authenticationBean.error}" id="error" styleClass="error"/>


                    <rich:panel header="Control Panel :: Login" style="width: 60%;margin-left:auto;margin-right:auto;">
                        <!-- Startus of progress -->

                        <!--  put content here...    -->
                        <h:form id="loginForm">

                            <h:panelGrid columns="2" rendered="#{not authenticationBean.loggedIn}">

                                <h:outputText value="Username" />
                                <h:panelGroup>
                                    <h:inputText  id="name" required="true" requiredMessage="Username required"  label="Username" value="#{authenticationBean.username}">
                                        <rich:ajaxValidator event="onblur"/>
                                    </h:inputText>
                                    <rich:message for="name"/>
                                </h:panelGroup>




                                <h:outputText value="Password" />
                                <h:panelGroup>
                                    <h:inputSecret  id="password" required="true" requiredMessage="Password required"  label = "Password" value="#{authenticationBean.password}">
                                        <rich:ajaxValidator event="onblur"/>
                                    </h:inputSecret>
                                    <rich:message for="password"/>
                                </h:panelGroup>

                                <rich:spacer height="4px" />  


                                <a4j:commandButton value="Login" id="loginButton" reRender="output, error" action="#{authenticationBean.login}"/>

                                <rich:hotKey key="return"
                                             handler="#{rich:element('loginButton')}.click()" 
                                             selector="#loginForm"/>
                            </h:panelGrid>
                            <h:panelGrid>

                            </h:panelGrid>

                            <h:panelGrid rendered="#{authenticationBean.loggedIn}">
                                <p>You are logged in. <h:commandLink action="#{pageController.alreadyLoggedIn}" value ="Manage Users"/></p>
                            </h:panelGrid>

                        </h:form>

                        <!--    End put content     -->
                    </rich:panel>
                    <rich:spacer height="50px"/>


                </center>
                <p>&nbsp;</p>
            </div>

            <!-- wrap ends here -->
        </div>

        <!-- footer starts here -->
        <div>

            <div style="position: fixed; left:0px; right:0px; bottom: 0px; width: 100%; height: 34px; background-color: white; alignment-adjust: central; text-align: center; background-color: #C2C2A3;">

                <p>
                    &copy; <h:outputLabel value="#{copyrightYear.year}"/> <a href="http://www.mspace.co.ke"><strong>MSpace Solutions Ltd.</strong></a><strong> </strong>&nbsp;&nbsp;</p>

            </div>

        </div>

    </body>
</html>
</f:view>
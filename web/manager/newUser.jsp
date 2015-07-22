<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>
<rich:panel style="margin-left:auto; margin-right:auto" header="ADD USER FORM">
    <rich:panel  style="margin-right:auto; margin-left:auto;" rendered="#{user.message ne null}">
        <h:outputLabel  value="#{user.message}" id="message" styleClass="success"/>
    </rich:panel>

    <h:form id="addUserForm">

        <h:panelGrid id="addUserPanelGrid" columns="3" style="width:100%;" columnClasses="one, two, three">
            <h:panelGroup layout="block">

                <h:outputText value="Username : "></h:outputText>

            </h:panelGroup>
            <h:panelGroup layout="block">
                <h:inputText id="username" size="34" value="#{user.username}"> 
                    <f:validator validatorId="customUsernameValidator"/>
                    <rich:ajaxValidator event="onblur"/>
                </h:inputText>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <rich:message for="username" style="color:red;"/>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:outputText value="Password : " ></h:outputText>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:inputText id="password" size="34" required="true" requiredMessage="Password Required" value="#{user.password}">

                    <rich:ajaxValidator event="onblur"/>
                </h:inputText>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <rich:message for="password" style="color:red;"/>
            </h:panelGroup>

            <h:panelGroup  layout="block">
                <h:outputText value="SMS Credits :"></h:outputText>
            </h:panelGroup>

            <h:panelGroup  layout="block">
                <h:inputText id="smsCredits" size="34" required="true" requiredMessage="SMS Credits Required" value="#{user.smsCredits}">
                    <rich:ajaxValidator event="onblur"/>
                </h:inputText>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <rich:message for="smsCredits" style="color:red;"/>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:outputText value="Organization :"></h:outputText>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:inputText id="org" size="34" required="true" requiredMessage="Organization Required" value="#{user.organization}">
                    <rich:ajaxValidator event="onblur"/>
                </h:inputText>
            </h:panelGroup>


            <h:panelGroup layout="block">
                <rich:message for="org" style="color:red;"/>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:outputText value="Alphanumeric :"></h:outputText>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:inputText id="alphanumeric" size="34" value="#{user.alphanumeric}">

                </h:inputText>
            </h:panelGroup>


            <h:panelGroup layout="block">
                <rich:message for="alphanumeric" style="color:red;"/>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:outputText value="User Mobile :"></h:outputText>
            </h:panelGroup>

            <h:panelGroup  layout="block">
                <h:inputText id="mobile" size="34" required="true" requiredMessage="Mobile Number Required" value="#{user.userMobile}">
                    <rich:ajaxValidator event="onblur"/>
                </h:inputText>
            </h:panelGroup>

            <h:panelGroup  layout="block">
                <rich:message for="mobile" style="color:red;"/>
            </h:panelGroup>

            <h:panelGroup  layout="block">
                <h:outputText value="User Email :"></h:outputText>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:inputText id="email" size="34" value="#{user.userEmail}">
                    <rich:ajaxValidator event="onblur"/>
                </h:inputText>
            </h:panelGroup>
            <h:panelGroup layout="block">
                <rich:message for="email" style="color:red;"/>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:outputText value="Enable email alert when credit is over?"></h:outputText>
            </h:panelGroup>

            <h:panelGroup layout="block">
                <h:selectBooleanCheckbox id="alert" value="#{user.enableEmailAlertWhenCreditOver}"></h:selectBooleanCheckbox>
            </h:panelGroup>
            <h:panelGroup layout="block">
                <rich:message for="alert" style="color:red;"/>
            </h:panelGroup>



            <h:panelGroup layout="block">
                <a4j:commandButton  reRender="message" value="SAVE" id="action" action="#{user.saveUser}"/>
                <rich:hotKey key="return"
                                             handler="#{rich:element('action')}.click()" 
                                             selector="#addUserForm"/>
            </h:panelGroup>
            

        </h:panelGrid>

    </h:form>
</rich:panel>
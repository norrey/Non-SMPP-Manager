<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>

<h:form>

    <h:panelGrid width="100%" style="text-align:center; margin-right:auto; margin-left:auto;" columns="3">

        <h:outputText></h:outputText>

        <h:inputHidden id="id" requiredMessage="Username Required" required="true" value="#{userScrollerBean.currentUser.id}"> 
        </h:inputHidden>
        <rich:message for="id"/>

        <h:outputText></h:outputText>
        <h:inputHidden id="previoususerID" value="#{userScrollerBean.currentUser.previousUsername}"> 
        </h:inputHidden>
        <rich:message for="previoususerID"/>



        <h:outputText value="Username : "></h:outputText>
        <h:inputText id="username" requiredMessage="Username Required" required="true" value="#{userScrollerBean.currentUser.username}"> 

            <f:validator validatorId="customUsernameValidator"/>
            <rich:ajaxValidator event="onblur"/>
        </h:inputText>
        <rich:message for="username"/>



        <h:outputText value="Password : "></h:outputText>

        <h:inputText id="password" required="true" requiredMessage="Password Required" value="#{userScrollerBean.currentUser.password}">

            <rich:ajaxValidator event="onblur"/>
        </h:inputText>
        <rich:message for="password" errorClass="ERROR"/>

        <h:outputText value="Organization :"></h:outputText>
        <h:inputText id="org" required="true" requiredMessage="Organization Required" value="#{userScrollerBean.currentUser.organization}">
            <rich:ajaxValidator event="onblur"/>
        </h:inputText>
        <rich:message for="org"/>

        <h:outputText value="User Mobile :"></h:outputText>
        <h:inputText id="mobile" required="true" requiredMessage="Mobile Number Required" value="#{userScrollerBean.currentUser.userMobile}">
            <rich:ajaxValidator event="onblur"/>
        </h:inputText>
        <rich:message for="mobile"/>

        <h:outputText value="User Email"></h:outputText>
        <h:inputText id="email" value="#{userScrollerBean.currentUser.userEmail}">
            <rich:ajaxValidator event="onblur"/>
        </h:inputText>
        <rich:message for="email"/>

        <h:outputText value="Enable email alert when credit is over?"></h:outputText>
        <h:selectBooleanCheckbox id="alert" value="#{userScrollerBean.currentUser.enableEmailAlertWhenCreditOver}"></h:selectBooleanCheckbox>
        <rich:message for="alert"/>

    </h:panelGrid>
    <h:inputHidden id="smsCredits" value="#{userScrollerBean.currentUser.smsCredits}"/>
</h:form>

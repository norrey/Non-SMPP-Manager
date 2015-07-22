<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>


<h:panelGrid width="100%" style="margin-left:auto; margin-right:auto;" columnClasses="manageSMSCol1, manageSMSCol2" columns="2">
    <h:panelGroup layout="block">
        <h:outputText value="Username : "></h:outputText>
    </h:panelGroup>

    <h:panelGroup layout="block">
        <h:outputLabel id="user_username" value="#{userScrollerBean.currentUser.username}"/>
    </h:panelGroup>


    <h:panelGroup layout="block">
        <h:outputText value="Available SMS Credits : "></h:outputText>
    </h:panelGroup>
    <h:panelGroup layout="block">
        <h:outputLabel id="smsCredit"  value="#{userScrollerBean.currentUser.smsCredits}"/>
    </h:panelGroup>


    <h:panelGroup layout="block">
        <h:outputText value="Select Action"/>
    </h:panelGroup>
    <h:panelGroup layout="block">
        <h:selectOneMenu id="selectedAction" value="#{userScrollerBean.currentUser.creditManageType}">
            <f:selectItem itemValue="add" itemLabel="Add Credit"/>
            <f:selectItem itemValue="update" itemLabel="Alter Credit"/>
        </h:selectOneMenu>
    </h:panelGroup>

    <h:panelGroup layout="block">
        <h:outputText value="SMS Credit Value : "></h:outputText>
    </h:panelGroup>
    <h:panelGroup layout="block">
        <h:inputText id="manageCredits" requiredMessage="Cannot be blank" required="true" value="#{userScrollerBean.currentUser.creditsToManage}">

        </h:inputText>
    </h:panelGroup>


<h:panelGroup layout="block">
    <a4j:commandButton value="Excute"
                       action="#{userScrollerBean.currentUser.manageCredit()}"
                       reRender="updateMessage"
                       oncomplete="if (#{facesContext.maximumSeverity==null}) #{rich:component('creditPanel')}.hide();" />

</h:panelGroup>

</h:panelGrid>
<h:inputHidden id="secret_username" value="#{userScrollerBean.currentUser.username}"/>
<h:inputHidden id="secrete_smsCredit"  value="#{userScrollerBean.currentUser.smsCredits}"/>


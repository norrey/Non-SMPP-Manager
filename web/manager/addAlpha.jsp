<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>

<h:form>

    <h:panelGrid width="100%" style="text-align:center; margin-right:auto; margin-left:auto;" columns="3">

        <h:outputText value=""></h:outputText>
        <h:inputHidden id="org_username" value="#{userScrollerBean.currentUser.username}">

        </h:inputHidden>
        <rich:message for="org_username"/>

        <h:outputText value="Username : "></h:outputText>
        <h:outputLabel id="hidden_username" value="#{userScrollerBean.currentUser.username}">

        </h:outputLabel>
        <rich:message for="hidden_username"/>

        <h:outputText value="Alphanumeric : "></h:outputText>
        <h:inputText id="org_alphanumeric" requiredMessage="Alphanumeric Required" required="true" value="#{userScrollerBean.currentUser.alphanumeric}">

        </h:inputText>
        <rich:message for="org_alphanumeric"/>


    </h:panelGrid>
</h:form>

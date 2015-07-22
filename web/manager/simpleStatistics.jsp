<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<!-- RichFaces tag library declaration -->

<%@ taglib uri="http://richfaces.org/a4j" prefix="a4j"%>

<%@ taglib uri="http://richfaces.org/rich" prefix="rich" %>
<rich:panel style="margin-left:auto; margin-right:auto" header="SIMPLE STATISTICS">
    <h:form>

        <h:panelGrid id="simpleStatsGrid" columns="2" style="width:100%;" columnClasses="reportTableCol1, reportTableCol2">
            <h:panelGroup layout="block">

                <h:outputText value="Total Number of Users : "></h:outputText>

            </h:panelGroup>
            <h:panelGroup layout="block">
                <h:outputText value="#{user.simpleStatistics().get('numberOfUsers')}"/>
            </h:panelGroup>

            
            
            <h:panelGroup layout="block">

                <h:outputText value="Total Number SMS Credits Awarded : "></h:outputText>

            </h:panelGroup>
            <h:panelGroup layout="block">
                <h:outputText value="#{user.simpleStatistics().get('totalCreditsAssigned')}"/>
            </h:panelGroup>

            
            
            <h:panelGroup layout="block">

                <h:outputText value="Highest Number of SMS Credits Awarded : "></h:outputText>

            </h:panelGroup>
            <h:panelGroup layout="block">
                <h:outputText value="#{user.simpleStatistics().get('highestCreditAwarded')}"/>
            </h:panelGroup>

            
            
            <h:panelGroup layout="block">

                <h:outputText value="Lowest Number of SMS Credits Awarded : "></h:outputText>

            </h:panelGroup>
            <h:panelGroup layout="block">
                <h:outputText value="#{user.simpleStatistics().get('lowestCreditAwarded')}"/>
            </h:panelGroup>

           
           
           <h:panelGroup layout="block">

                <h:outputText value="Average Number of SMS Credits Awarded : "></h:outputText>

            </h:panelGroup>
            <h:panelGroup layout="block">
                <h:outputText value="#{user.simpleStatistics().get('averageCreditAwarded')}"/>
            </h:panelGroup>



        </h:panelGrid>
        
    </h:form>
</rich:panel>
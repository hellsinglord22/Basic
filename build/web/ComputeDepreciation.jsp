<%-- 
    Document   : ComputeDepreciation
    Created on : Oct 22, 2017, 4:39:51 PM
    Author     : Ana Malimpensa
--%>

<!-- ComputeDepreciation.jsp -->
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>
<html>
    
    <head>
        <title>ComputeDepreciation</title>
             
      
    <body>
        <% 
            // check input
                  
            
           String selectedItem = request.getParameter("depForms");
           double cost = Double.parseDouble(request.getParameter("cost"));
           double scrap = Double.parseDouble(request.getParameter("scrapValue"));
           int life = Integer.parseInt(request.getParameter("productLife"));
           double unitsUsed = Double.parseDouble(request.getParameter("consumeUL"));
           double[] unitsUsedPerYear = new double[life];
           //initialize this array with the values of the array in html find out how to 
           //display dinamically an array and get the values
           
          /* for (int x = 0; x < life; x++) {
           
           unitsUsedPerYear[x] = // array from HTML Double.parseDouble(request.getParameter("consumeUL"));
           
           }*/
           
           double accDepre = 0.0;
           double[] depArr= new double[life];
           

            %>
  
<TABLE WIDTH= "50%" ALIGN="CENTER" CELLPADDING="15" BORDER="5">


<TH BGCOLOR="BLUE">YEAR</TH>
<TH BGCOLOR="WHITE">DEPRECIATION</TH>
<TH BGCOLOR="YELLOW">ACCUM. DEPRECIATION</TH>

<TABLE WIDTH= "50%" ALIGN="CENTER" CELLPADDING="15" BORDER="5">
<TH BGCOLOR="WHITE">Year</TH>
<TH BGCOLOR="WHITE">Amount</TH>

<%
      
      if(selectedItem.equals("SL"))
      {
        out.println("<CENTER> <H1>Straight-Line Depreciation</H1></CENTER><BR /></P>");
           
     for (int i = 0; i < depArr.length; i++)
      {
        
        depArr[i]=(cost - scrap)/ life;
        accDepre += depArr[i];
        DecimalFormat df = new DecimalFormat("#####.00");  

        out.println("<TR><TD BGCOLOR=BLUE>" + (i+1)+ "</TD>" +"<TD BGCOLOR=WHITE>"+ df.format(depArr[i]) +"</TD>" +"<TD BGCOLOR=YELLOW>" +df.format(accDepre)  + "</TD></TR>");
      
      }
   }
    else if(selectedItem.equals("SUM"))
    {
      
      int S= (life*(life+1))/2;
      out.println("&nbsp&nbsp<CENTER><FONT COLOR=GREEN><H1>Sum-of-the-Years-Digits Depreciation</H1></FONT></CENTER><BR />");
      

   
       for (int y = 0; y < depArr.length; y++)
      {
        
        depArr[y]=((cost - scrap)*(double)(life-y))/S;
        accDepre += depArr[y];
        DecimalFormat df = new DecimalFormat("#####.00");  

        out.println("<TR><TD BGCOLOR=BLUE>" + (y+1)+ "</TD>" +"<TD BGCOLOR=WHITE>"+ df.format(depArr[y]) +"</TD>" +"<TD BGCOLOR=YELLOW>" +df.format(accDepre)  + "</TD></TR>");

         }
     }
 
    else if(selectedItem.equals("UP"))
    {
        
        
      double sumOfUnitsYear = 0.0;
      double depreForEach= (cost - scrap)/unitsUsed;
                  
      for (int idx = 0; idx < life; idx++)
      {
          sumOfUnitsYear += unitsUsedPerYear[idx];
          if (sumOfUnitsYear > unitsUsed)
              out.println("The units used exceed the total units used in its useful life in year " + unitsUsedPerYear[idx]);
      
      }
      
      if (sumOfUnitsYear < unitsUsed)
          out.println("The sum of units used per year is less than the expected for its useful life ");
      // sum of all ul array ach year of its useful life must be th same as unitsUded !!Flaf it as an error
      
      out.println("&nbsp&nbsp<CENTER><FONT COLOR=GREEN><H1>Units Of Production Depreciation</H1></FONT></CENTER><BR />");
      
       for (int x = 0; x < life; x++)
      {
        
        DecimalFormat df = new DecimalFormat("#####.00");  

        out.println("<TR><TD BGCOLOR=PINK>" + (x+1)+ "</TD>" +"<TD BGCOLOR=YELLOW>"+ df.format(unitsUsedPerYear[x]) +"</TD></TR>");

         }
      
   
       for (int x = 0; x < depArr.length; x++)
      {
        
        depArr[x]= depreForEach * unitsUsedPerYear[x];
        accDepre += depArr[x];
        DecimalFormat df = new DecimalFormat("#####.00");  

        out.println("<TR><TD BGCOLOR=PINK>" + (x+1)+ "</TD>" +"<TD BGCOLOR=YELLOW>"+ df.format(depArr[x]) +"</TD>" +"<TD BGCOLOR=SALMON>" +df.format(accDepre)  + "</TD></TR>");

         }
     }
      
    else 
    {
      
      out.println("&nbsp&nbsp<CENTER><FONT COLOR=GREEN><H1>Double Declining Balance Depreciation</H1></FONT></CENTER><BR />");
      

   
       for (int x = 0; x < depArr.length; x++)
      {
        // correct the calculation
        double diff = cost - scrap;
        depArr[x]= (2.0/life)* cost;
        accDepre += depArr[x];
        cost -= depArr[x];
       
         
        DecimalFormat df = new DecimalFormat("#####.00");  

        out.println("<TR><TD BGCOLOR=PINK>" + (x+1)+ "</TD>" +"<TD BGCOLOR=YELLOW>"+ df.format(depArr[x]) +"</TD>" +"<TD BGCOLOR=SALMON>" +df.format(accDepre)  + "</TD></TR>");

         }
     }
      

%>

 
</head>

  </body> 
 </html>
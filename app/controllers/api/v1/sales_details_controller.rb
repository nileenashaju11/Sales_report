class Api::V1::SalesDetailsController < ApplicationController
  def index

   ##Yearly Calculation
    
    sale_details=SaleDetail.all.group_by { |m| m.trans_date.beginning_of_year } 
    @yearly_sales_report=[]
    sale_details.each do |i,j|
       last_buy_price=0
       trans_quantity=0
       trans_ex_total=0
       trans_tax_total=0
       trans_discount=0
       j.each do|k|
    
        last_buy_price=last_buy_price+k.last_buy_price
        trans_quantity=trans_quantity+k.trans_quantity
        trans_ex_total=trans_ex_total+k.trans_total_extax_value
        trans_tax_total=trans_tax_total+k.trans_total_tax
        trans_discount=trans_discount+k.trans_total_discount_given
      end
      sales=trans_ex_total+trans_tax_total-trans_discount
      profit=sales - last_buy_price
      @yearly_sales_report << {
         month_year:i.strftime("%Y"),
         buy_price:last_buy_price,
         quantity:trans_quantity,
         sales:sales,
         profit: profit.round(2)
      }

    end
    @report_quntity=[]
    @report_profit=[]
    @report_year=[]
    @yearly_sales_report.each do |sale_month| 
      @report_quntity<<sale_month[:quantity] 
      @report_profit<<sale_month[:profit]
      @report_year<<sale_month[:month_year].to_s  
    end
   
  ##Monthly Calculation

   sale_details_month=SaleDetail.all.group_by { |m| m.trans_date.beginning_of_month }
    @monthly_sales_report=[]
    sale_details_month.each do |i,j|
       last_buy_price=0
       trans_quantity=0
       trans_ex_total=0
       trans_tax_total=0
       trans_discount=0
       j.each do|k|
    
        last_buy_price=last_buy_price+k.last_buy_price
        trans_quantity=trans_quantity+k.trans_quantity
        trans_ex_total=trans_ex_total+k.trans_total_extax_value
        trans_tax_total=trans_tax_total+k.trans_total_tax
        trans_discount=trans_discount+k.trans_total_discount_given
      end
      sales=trans_ex_total+trans_tax_total-trans_discount
      profit=sales - last_buy_price
      @monthly_sales_report << {
         month:i.strftime("%m"),
         year:i.strftime("%Y"),
         buy_price:last_buy_price,
         quantity:trans_quantity,
         sales:sales,
         profit: profit.round(2)
      }

    end
    @monthly_sales_report_alt={}

    @monthly_sales_report.each do |sale|
      @monthly_sales_report_alt[sale[:year]] ||= []
      @monthly_sales_report_alt[sale[:year]] << sale
    end  
     
 render json: {all_data:{data: @yearly_sales_report, data1: @monthly_sales_report_alt}}

   end 
end

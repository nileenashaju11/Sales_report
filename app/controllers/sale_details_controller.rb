class SaleDetailsController < ApplicationController
  def index
  ##Yearly Calculation


    sale_details=SaleDetail.all.group_by { |m| m.trans_date.beginning_of_year }
    @sale_month=[]
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
      @sale_month << {
         month_year:i.strftime("%Y"),
         buy_price:last_buy_price,
         quantity:trans_quantity,
         sales:sales,
         profit: profit
      }

    end
    @report_quntity=[]
    @report_profit=[]
    @report_year=[]
    @sale_month.each do |sale_month| 
      @report_quntity<<sale_month[:quantity] 
      @report_profit<<sale_month[:profit]
      @report_year<<sale_month[:month_year].to_s  
    end
   

  ##Monthly Calculation



   sale_details_month=SaleDetail.all.group_by { |m| m.trans_date.beginning_of_month }
    @sale_months=[]
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
      @sale_months << {
         month:i.strftime("%m"),
         year:i.strftime("%Y"),
         buy_price:last_buy_price,
         quantity:trans_quantity,
         sales:sales,
         profit: profit
      }

    end
    @sale_months_alt={}

    @sale_months.each do |sale|
      @sale_months_alt[sale[:year]] ||= []
      @sale_months_alt[sale[:year]] << sale
    end   
end 
end

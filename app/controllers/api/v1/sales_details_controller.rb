class Api::V1::SalesDetailsController < ApplicationController
  # def index

  #  ##Yearly Calculation
    
  #   sale_details=SaleDetail.all.group_by { |m| m.trans_date.beginning_of_year } 
  #   @yearly_sales_report=[]
  #   sale_details.each do |i,j|
  #      last_buy_price=0
  #      trans_quantity=0
  #      trans_ex_total=0
  #      trans_tax_total=0
  #      trans_discount=0
  #      j.each do|k|
    
  #       last_buy_price=last_buy_price+k.last_buy_price
  #       trans_quantity=trans_quantity+k.trans_quantity
  #       trans_ex_total=trans_ex_total+k.trans_total_extax_value
  #       trans_tax_total=trans_tax_total+k.trans_total_tax
  #       trans_discount=trans_discount+k.trans_total_discount_given
  #     end
  #     sales=trans_ex_total+trans_tax_total-trans_discount
  #     profit=sales - last_buy_price
  #     @yearly_sales_report << {
  #        month_year:i.strftime("%Y"),
  #        buy_price:last_buy_price,
  #        quantity:trans_quantity,
  #        sales:sales,
  #        profit: profit.round(2)
  #     }

  #   end
  #   @report_quntity=[]
  #   @report_profit=[]
  #   @report_year=[]
  #   @yearly_sales_report.each do |sale_month| 
  #     @report_quntity<<sale_month[:quantity] 
  #     @report_profit<<sale_month[:profit]
  #     @report_year<<sale_month[:month_year].to_s  
  #   end
   
  # ##Monthly Calculation

  #  sale_details_month=SaleDetail.all.group_by { |m| m.trans_date.beginning_of_month }
  #   @monthly_sales_report=[]
  #   sale_details_month.each do |i,j|
  #      last_buy_price=0
  #      trans_quantity=0
  #      trans_ex_total=0
  #      trans_tax_total=0
  #      trans_discount=0
  #      j.each do|k|
    
  #       last_buy_price=last_buy_price+k.last_buy_price
  #       trans_quantity=trans_quantity+k.trans_quantity
  #       trans_ex_total=trans_ex_total+k.trans_total_extax_value
  #       trans_tax_total=trans_tax_total+k.trans_total_tax
  #       trans_discount=trans_discount+k.trans_total_discount_given
  #     end
  #     sales=trans_ex_total+trans_tax_total-trans_discount
  #     profit=sales - last_buy_price
  #     @monthly_sales_report << {
  #        month:i.strftime("%m"),
  #        year:i.strftime("%Y"),
  #        buy_price:last_buy_price,
  #        quantity:trans_quantity,
  #        sales:sales,
  #        profit: profit.round(2)
  #     }

  #   end
  #   @monthly_sales_report_alt={}

  #   @monthly_sales_report.each do |sale|
  #     @monthly_sales_report_alt[sale[:year]] ||= []
  #     @monthly_sales_report_alt[sale[:year]] << sale
  #   end  
     
 

  #  end 


  def index
    @yearly_slaesreport = yearly_sales_calculation
    

    @monthly_salereport_data = montly_sales_report

    render json: {all_data:{data: @yearly_slaesreport, data1: @monthly_salereport_data}}
   
  end
  

  ##Yearly Calculation

    
  def yearly_sales_calculation
    yearly_sales_report=SaleDetail.all.group_by { |m| m.trans_date.beginning_of_year }
    yearly_salereport_data=[]
    yearly_sales_report.each do |key,value|
       total_buy_price=0
       total_trans_quantity=0
       trans_extax_total=0
       trans_tax_total=0
       total_trans_discount=0
       value.each do|k|
    
        total_buy_price=total_buy_price+k.last_buy_price
        total_trans_quantity=total_trans_quantity+k.trans_quantity
        trans_extax_total=trans_extax_total+k.trans_total_extax_value
        trans_tax_total=trans_tax_total+k.trans_total_tax
        total_trans_discount=total_trans_discount+k.trans_total_discount_given
      end
      yearly_total_sale=trans_extax_total+trans_tax_total-total_trans_discount
      yearly_profit=yearly_total_sale - total_buy_price
      yearly_salereport_data << {
         year:key.strftime("%Y"),
         buy_price:total_buy_price,
         quantity:total_trans_quantity,
         sales:yearly_total_sale,
         profit: yearly_profit.round(2)
      }

    end
    report_quntity=[]
    report_profit=[]
    report_year=[]
    yearly_salereport_data.each do |sale_year| 
      report_quntity<<sale_year[:quantity] 
      report_profit<<sale_year[:profit]
      report_year<<sale_year[:month_year].to_s  
    end
    
    return yearly_salereport_data
    
  end 

  #Monthly Calculation

def montly_sales_report

   monthly_sales_report=SaleDetail.all.group_by { |m| m.trans_date.beginning_of_month }
   monthly_salereport_data=[]
    monthly_sales_report.each do |key,value|
       monthly_buy_price=0
       monthly_trans_quantity=0
       trans_taxex_total=0
       monthly_trans_tax_total=0
       monthlytrans_discount=0
       value.each do|k|
    
        monthly_buy_price=monthly_buy_price+k.last_buy_price
        monthly_trans_quantity=monthly_trans_quantity+k.trans_quantity
        trans_taxex_total=trans_taxex_total+k.trans_total_extax_value
        monthly_trans_tax_total=monthly_trans_tax_total+k.trans_total_tax
        monthlytrans_discount=monthlytrans_discount+k.trans_total_discount_given
      end
      monthily_sales=trans_taxex_total+monthly_trans_tax_total-monthlytrans_discount
      monthily_profit=monthily_sales - monthly_buy_price

      monthly_salereport_data << {
         month:key.strftime("%m"),
         year:key.strftime("%Y"),
         buy_price:monthly_trans_quantity,
         quantity:monthly_trans_quantity,
         sales:monthily_sales,
         profit: monthily_profit.round(2)
      }

    end
    monthly_salereport_data_alt={}

    monthly_salereport_data.each do |sale|
      monthly_salereport_data_alt[sale[:year]] ||= []
      monthly_salereport_data_alt[sale[:year]] << sale
    end
    return monthly_salereport_data_alt   
end
end

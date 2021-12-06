class SaleDetailsController < ApplicationController
  def index
    yearly_slaesreport = yearly_sales_calculation
    @report_quntity = yearly_slaesreport[0]
    @report_profit= yearly_slaesreport[1]
    @report_year=yearly_slaesreport[2]

    @monthly_salereport_data = montly_sales_report
   
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
    
    return report_quntity,report_profit, report_year
    
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


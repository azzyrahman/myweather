module CssHelper
 
  def nav_class(path)
    'active' if current_page?(path)
  end

  def nav_class_radar(state=nil)
    if state
      'active' if current_page?("/weather/radar/wzstate/#{state}")
    else
      'active' if controller.action_name.end_with?('radar')
    end  
  end

  def frost_risk_class (frost_risk)
    frost_risk ? "local_grad_frost_#{frost_risk.downcase}" : "bg_yellow"
  end     

  def uv_class (uv_text)
    uv_text ? "local_grad_uv_#{uv_text.downcase.gsub(/\s/,'_')}" : "bg_yellow" 
  end     
      
end  
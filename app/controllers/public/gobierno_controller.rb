# encoding: utf-8
class Public::GobiernoController < Public::OutletsController
  layout "gobierno"
  
  def verify
    @errors ||= {};
    @errors[:bad_service_url] = " Lo sentimos pero no podemos buscar el URL que proporcionó debido a que no es parte de los servicios de redes sociales que podemos verificar.";
    @errors[:bad_account] = " parece estar incompleto. El URL completo debe incluir un nombre de usuario.";
    @errors[:help_msg] = "";
    super
  end
end
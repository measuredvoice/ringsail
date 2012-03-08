# encoding: utf-8
class GobiernoController < OutletsController
  layout "gobierno"
  
  def verify
    @errors ||= {};
    @errors[:bad_service_url] = " Lo sentimos pero no podemos buscar el URL que proporcion&oacute; debido a que no es parte de los servicios de redes sociales que podemos verificar.";
    @errors[:bad_account] = " El URL que proporcion&oacute; parece estar incompleto. El URL completo debe incluir un nombre de usuario.";
    @errors[:help_msg] = "";
    super
  end
end
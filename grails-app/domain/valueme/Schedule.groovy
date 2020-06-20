package valueme
import grails.databinding.BindingFormat

class Schedule {

	@BindingFormat('dd/MM/yyyy')
	Date startDate
	@BindingFormat('dd/MM/yyyy')
	Date endDate
	int vigency
	boolean active


    static constraints = {
    	vigency unique: true
    	vigency index: true
    }
}

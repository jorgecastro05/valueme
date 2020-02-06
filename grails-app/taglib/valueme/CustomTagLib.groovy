package valueme
import java.text.DecimalFormat

class CustomTagLib {
    static defaultEncodeAs = [help:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def help = { attrs, body ->
    	out << '<small><i class="circular help icon link" data-variation="very wide"'
    	out << ' data-content="'
    	out << message(code: attrs.message)
    	out << '"></i></small>'
    }


    def criteria = { attrs, body ->
        def percentform = new DecimalFormat("###.##%")
        String percent = " (" + percentform.format(attrs.value/5) +")"
    	if(attrs.value < 3){
            out << 'Bajo' + percent
        }else if(attrs.value < 4){
            out << 'Medio' + percent
        }else if(attrs.value <= 5){
            out << 'Alto' + percent
        }
    }

    def helpLink = { attrs,body ->
        out << '<a href="https://valueme.lalius.com/wiki/doku.php?id='
        out << attrs.page
        out << '" target="_blank" >'
        out << '&nbsp;<i class="fitted small circular help link icon"></i>'
        out << '</a>'
    }

    def currentYear = { attrs, body ->
        Date year = new Date()
        out << year[Calendar.YEAR]
    }

}

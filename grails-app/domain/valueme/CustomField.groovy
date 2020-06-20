package valueme

class CustomField {

	String type
	List<String> value
	String name
	String description
	String section
	boolean active
	boolean required

    static constraints = {
    name unique: true
    value index: true
    }
}

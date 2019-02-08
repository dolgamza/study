// check email 
function checkEmail(fieldid) {
	var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if (!fieldid.val()) return false;
	return regEmail.test(fieldid.val());
}

// check phone number
function checkPhone(fieldid) {
	var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
	if (!fieldid.val()) return false;
	return regPhone.test(fieldid.val());
}

// check string length
function checkLength(fieldid, intMin, intMax) {
	fieldid.val(fieldid.val().trim());
	return (fieldid.val().length < intMin || fieldid.val().length > intMax) ? false : true;
}

// check wrong character
function checkInapposite(fieldid) {
	var pattern = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9 ,~!@#\?\|\\\<\>\$\%\^\&\:\;\\/*\.\-\_\=\+\(\)\{\}\[\]\'\")]/gi;
	return !pattern.test(fieldid.val());
}

//check userid
function checkId(fieldid) {
	var pattern =/^[a-zA-Z0-9]+$/gi;
	return !pattern.test(fieldid.val());
}

//check password
function checkPw(fieldid) {
	var pattern = /^[a-zA-Z0-9!@#$%^&*+=-]+$/gi;
	return !pattern.test(fieldid.val());
}

// only permit number
// it's for key-up event
function numberOnly(obj) { 
	 $(obj).keyup(function(event){
		if(event.keyCode != 8 && event.keyCode != 37 && event.keyCode != 38 && event.keyCode != 39 && event.keyCode != 40) {
			$(this).val($(this).val().replace(/[^0-9]/g,""));
		}
    });
}

function getDateFormat(obj, pattern) { 
	$(obj).val($(obj).val().replace(/([0-9]{4})([0-9]{2})([0-9]{2})/,'$1'+pattern+'$2'+pattern+'$3'));
}

function getDateFormatReset(obj) {
	$(obj).val($(obj).val().replace(/[^0-9]/g,""));
}

function getHTelNum(obj) { 
	 $(obj).keyup(function(){
        $(this).val($(this).val().replace(/(^01.{1}|[0-9]{3})([0-9]{4})([0-9]{4})/,'$1-$2-$3'));
   });
}

///////////////////// DECIMAL CHECKER ////////////////////////////

Number.prototype.format = function(pattern) {
	var size = new Array("", "");
	if (pattern.indexOf(".")>-1) size = pattern.split(".");
	else size[0] = pattern;
	var n = this + "";
	var x = (n.indexOf(".")>-1) ? n.split(".") : (n+"."+size[1]).split(".");
	x[0] = size[0] + x[0];
	x[1] += size[1];
	x[0] = x[0].substring(x[0].length-size[0].length, x[0].length);
	x[1] = x[1].substring(0, size[1].length);
	return (pattern.indexOf(".")>-1) ? x.join(".") : x[0];
}

String.prototype.format = function(pattern) {
	var n = parseFloat(this);
	if(isNaN(n)) return pattern;
	return n.format(pattern);
}

String.prototype.patterntest = function(pattern) {
	var size = new Array("", "");
	if (pattern.indexOf(".")>-1) size = pattern.split(".");
	var x = (this.indexOf(".")>-1) ? this.split(".") : (this+".").split(".");
	x[0] = (x[0].length>size[0].length) ? x[0].substring(x[0].length-size[0].length, x[0].length) : x[0];
	x[1] = (x[1].length>size[1].length) ? x[1].substring(0, size[1].length) : x[1];
	return (pattern.indexOf(".")>-1 && this.indexOf(".")>-1) ? x.join(".") : x[0];
}

// onkeyup event. ex. onkeyup="decimalOnly(this, '00.00');"
decimalOnly = function(e, pattern) {
	e.value = e.value.replace(/[^0-9.]/g,"").patterntest(pattern);
}

// onfocusout event. ex. onfocusout="formatDecimal(this, '00.00');"
formatDecimal = function(e, pattern) {
	e.value = e.value.format(pattern);
}


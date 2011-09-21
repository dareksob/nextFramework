package nextFramework 
{
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.06
	 * @desciption allows you to filter/check objects by it property
	 */
	public class nfCondition
	{
		
		public function filter(list:Vector.<Object>, script:String):Vector.<Object> {
			var nlist = new Vector.<Object>();
			for each(var node:Object in list) {
				if (this.isTrue(node, script)) {
					nlist.push(node);
				}
			}
			return nlist;
		}
		
		public function isTrue(object:Object, script:String):Boolean {
			var code:Object;
			
			if (script.indexOf('>=') != -1) {
				code = this.replacePropCode(object, this.getCode(script, '>='));
				if (code.hasProp) {
					if (code.propLeft >= code.propRight) {
						return true;
					}
				}
			}else if (script.indexOf('<=') != -1) {
				code = this.replacePropCode(object, this.getCode(script, '<='));
				if (code.hasProp) {
					if (code.propLeft <= code.propRight) {
						return true;
					}
				}
			}else if (script.indexOf('>') != -1) {
				code = this.replacePropCode(object, this.getCode(script, '>'));
				if (code.hasProp) {
					if (code.propLeft > code.propRight) {
						return true;
					}
				}
			}else if (script.indexOf('<') != -1) {
				code = this.replacePropCode(object, this.getCode(script, '<'));
				if (code.hasProp) {
					if (code.propLeft < code.propRight) {
						return true;
					}
				}
			}else if (script.indexOf('==') != -1) {
				code = this.replacePropCode(object, this.getCode(script, '=='));
				if (code.hasProp) {
					if (code.propLeft == code.propRight) {
										
						return true;
					}
				}
			}else if (script.indexOf('!=') != -1) {
				code = this.replacePropCode(object, this.getCode(script, '!='));
				if (code.hasProp) {
					if (code.propLeft != code.propRight) {
						return true;
					}
				}
			}
			
			
			
			return false;
		}
		

		private function getCode(script:String, delim:String):Object {
			var parts:Array = script.split(delim);
			return {
				operator: delim,
				propLeft: parts[0],
				propRight: parts[1],
				hasProp: false
			}
		}
		
		private function replacePropCode(object:Object, code:Object):Object {
			//check property of object
			if (object.hasOwnProperty(code.propLeft)) {
				code.propLeft = object[code.propLeft];
				code.hasProp = true;
			}else { // convert to correct type
				code.propLeft = this.parseValue(code.propLeft);
			}
			
			if (object.hasOwnProperty(code.propRight)) {
				code.propRight = object[code.propRight];
				code.hasProp = true;
			}else { // convert to correct type
				code.propRight = this.parseValue(code.propRight);
			}
			
			
			return code;
		}
		
		private function parseValue(value:*):*{
			if (value is String) {
				if (value.indexOf("'") > -1) {
					value = value.split("'");
				}else if (value.indexOf('"') > -1) {
					value = value.split('"');
				}
				
				
				if (value is Array) {
					value = value.join('');
				}

				return value;
			}
			
			return parseFloat(value);
		}
		
		
	}

}
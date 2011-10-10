package nextFramework.flash 
{
	import flash.display.Shader;
	import flash.display.ShaderInput;
	import flash.display.ShaderParameter;
	import flash.display.ShaderParameterType;
	import nextFramework.nfRegistry;
	
	/*
	 * @author Darius Sobczak
	 * @website dsobczak.de
	 * @mail mail@dsobczak.de
	 *
	 * @website nextframework.de
	 * @version 1.07
	 */
	
	public final class nfFlashShader
	{
		
		public function nfFlashShader() { }
		static public function create():nfFlashShader {
			return new nfFlashShader();
		}
		
		public function setParameter(shader:Shader, conf:Object):nfFlashShader {
			
			//param
			for (var name:String in conf) {
				if (shader.data.hasOwnProperty(name)) {
					if (shader.data[name] is ShaderInput) {
						this.setShaderInput(shader, name, conf[name]);
					}else if (shader.data[name] is ShaderParameter) {
						this.setShaderParameter(shader, name, conf[name]);
					}
				}
			}
			
			return this;
		}
		
		public function setShaderParameter(shader:Shader, name:String, value:Object):nfFlashShader {
			try {
				if (!(value is Array)) {
					value = [value];
				}
				shader.data[name].value = value;
			}catch (error:Error) {
				nfRegistry.addLog(error.message, this);
			}
			return this;
		}
		
		public function setShaderInput(shader:Shader, name:String, value:Object):nfFlashShader {
			try{
				shader.data[name].src.image = value;
			}catch (error:Error) {
				nfRegistry.addLog(error.message, this);
			}
			return this;
		}
		
		// getter
		
		public function getShaderParameters(shader:Shader):Vector.<String> {
			var list:Vector.<String> = new Vector.<String>()
			for (var name:String in shader.data) {
				if (shader.data[name] is ShaderParameter) {
					list.push(name);
				}
			}
			return list;
		}
		
		public function getShaderInputs(shader:Shader):Vector.<String> {
			var list:Vector.<String> = new Vector.<String>()
			for (var name:String in shader.data) {
				if (shader.data[name] is ShaderInput) {
					list.push(name);
				}
			}
			return list;
		}
		
	}

}
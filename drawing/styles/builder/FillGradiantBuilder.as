package nextFramework.drawing.styles.builder 
{
	import nextFramework.drawing.styles.FillGradiant;
	import nextFramework.drawing.styles.IStyle;
	/**
	 * ...
	 * @author Darius Sobczak
	 */
	public class FillGradiantBuilder extends GradiantBuilder implements IStyleBuilder
	{
		
		public function FillGradiantBuilder(conf:Object = null) 
		{
			super(conf);
		}
		
		public function getStyle():IStyle {
			var style:FillGradiant = new FillGradiant();
			style.alphas = this.alphas.length > 0 ? this.alphas : null;
			style.colors = this.colors;
			style.fillType = this.fillType;
			style.focalPointRatio = this.focalPointRatio;
			style.interpolation = this.interpolation;
			style.matrix = this.matrix;
			style.ratios = this.ratios.length > 0 ? this.ratios : null;
			style.spread = this.spread;
			return style;
		}
	}

}
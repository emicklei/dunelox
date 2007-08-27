/*
   Copyright [2007] Ernest.Micklei @ PhilemonWorks.com

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
package com.philemonworks.flex.helpers
{
	import mx.controls.DataGrid;
	
	public class UIComponentHelper
	{
		/**
		 * Returns an array of column width values.
		 * 
		 * @param grid DataGrid
		 * @return Array with width value of each column in grid
		 */
		public static function getDataGridColumnWidths(grid:DataGrid):Array {
			var widths:Array = new Array()
			for (var i:int;i<grid.columnCount;i++) {
				widths.push(grid.columns[i].width)
			}
			return widths
		}
		/**
		 * Set the column width values of a DataGrid.
		 * 
		 * @param grid DataGrid
		 * @param value Array width values for each column in grid
		 */
		public static function setDataGridColumnWidths(grid:DataGrid,values:Array):void {
			if (grid.columnCount != values.length)
				trace('[UIComponentHelper] datagrid columns size does not match values length')
			for (var i:int;i<grid.columnCount;i++) {
				grid.columns[i].width = values[i]
			}
		}		
	}
}
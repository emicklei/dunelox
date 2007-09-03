/**
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
package com.philemonworks.flex.util
{
	import mx.controls.DataGrid;
	import flash.system.System;
	import mx.controls.dataGridClasses.DataGridColumn;
	
	/**
	 * ClipboardHelper is a utility that knows how to access data from controls and copy them to the OS clipboard
	 * 
	 * @author ernest.micklei@philemonworks.com
	 */
	public class ClipboardHelper
	{
		/**
		 * Copy the contents of the grid to the System clipboard.
		 * If a selection was made, copy that selection only
		 * Otherwise, copy the complete contents of the grid.
		 * 
		 * @param grid
		 */
		public static function copyFromDataGrid(grid:DataGrid):void {
			var lines:String = ""			
			if (grid.selectedItem != null) { // single row
				System.setClipboard(rowToStringFromDataGrid(grid.selectedItem,grid))
			} else if (grid.selectedIndices.length > 0) { // multiple rows
				for (var r:int=0;r<grid.selectedIndices.length;r++) {
					if (r>0) lines += "\n"
					lines += rowToStringFromDataGrid(grid.selectedItems[r],grid)
				}
				System.setClipboard(lines)
			} else { // complete table contents
				for (var r:int=0;r<grid.dataProvider.length;r++) {
					if (r>0) lines += "\n"
					lines += rowToStringFromDataGrid(grid.dataProvider[r],grid)
				}
				System.setClipboard(lines)
			}
		}
		/**
		 * Copy data from the row of a DataGrid onto a single String line
		 */
		private static function rowToStringFromDataGrid(item:Object,grid:DataGrid):String {
			var line:String = ""
			for (var c:int=0;c<grid.columnCount;c++) {
				if (c>0) line += "\t"
				var each_column:DataGridColumn = grid.columns[c]
				line += each_column.itemToLabel(item)												
			}
			return line
		}
	}
}
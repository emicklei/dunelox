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
	import mx.printing.PrintDataGrid;
	import flash.printing.PrintJob;
	import com.philemonworks.flex.dialogs.MessageDialog;
	import mx.containers.Canvas;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.utils.ColorUtil;
	import mx.controls.Alert;
	import mx.core.Application;
	import com.philemonworks.flex.events.ObjectDataEvent;
	import com.philemonworks.flex.nls.NLS;
	
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
		public static function printFromDataGrid(dataGrid:DataGrid):void {
			if (true) { Alert.show('No printing available yet'); return }
			var page:Canvas = new Canvas()	
			var printGrid:PrintDataGrid = new PrintDataGrid()
			printGrid.percentWidth = 100
			printGrid.percentHeight = 100
			printGrid.dataProvider = dataGrid.dataProvider
			for (var c:int;c<printGrid.columns.length;c++){
				var pc:DataGridColumn = new DataGridColumn()
				var vc:DataGridColumn = DataGridColumn(printGrid.columns[c])
				pc.dataField = vc.dataField
				pc.headerText = vc.headerText
				printGrid.columns.push(pc)
			}
			page.addChild(printGrid)
			
			var myPrintJob:PrintJob = new PrintJob();
		    myPrintJob.start() ;
		    try {
		    	page.height = myPrintJob.pageHeight
		    	page.width = myPrintJob.pageWidth
			    myPrintJob.addPage(page);
			    myPrintJob.send();
		    } catch (error:Error) {
		    	MessageDialog.showError(null,"Unable to print")
		    }		    			
		}
		/**
		 * Dispatch an event of type notify with a message found by a key using NLS
		 * This can be used by an application to display a notification to the user from any component in the hierarchy.
		 * 
		 * @param nls_key String
		 * @param args    Array optional string parameters for the message to bind
		 */
		public static function notify(nls_key:String, args:Array = null):void {
			var message:String = args == null? NLS.text(nls_key) : NLS.expandText(nls_key,args)
			Application.application.dispatchEvent(new ObjectDataEvent("notify",message))
		}			
	}
}
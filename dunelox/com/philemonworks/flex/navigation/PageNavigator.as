package com.philemonworks.flex.navigation
{
	import mx.rpc.events.ResultEvent;
	import flash.events.Event;
	import mx.controls.DataGrid;
	import flash.events.EventDispatcher;
	
	public class PageNavigator extends EventDispatcher
	{		
		public var resultFunction:Function;
		public var _bar:PageNavigationBar;
		public var _dataGrid:DataGrid;
		private var _pageLoaded:Function; 
	
		public var firstRowOnPage:Number = 0;
		public var lastRowOnPage:Number = 0;
		public var totalRows:Number = 0;
		public var rowsPerPage:Number = 0;
		
		[Bindable]
		public var preferredRowHeight:int = 10;
		[Bindable]
		public var sortmethod:String = "descending";
		[Bindable]
		public var sortkey:String = null;
		
		public function set navigationBar(newBar:PageNavigationBar):void{
			_bar = newBar;
			_bar.addEventListener("click" , pageRequested);
		}
		public function set dataGrid(newDataGrid:DataGrid):void {
			_dataGrid = newDataGrid
		}		
		public function set pageLoaded(callback:Function):void {
			_pageLoaded = callback
		}	
			
		
		// the user has requested to view a page (could be refresh of the current)
		public function pageRequested(event:Event):void {
			trace("PageNavigator>>user requested page")
			firstRowOnPage = (_bar.requestedPage - 1 ) * rowsPerPage
			this.rowsPerPage = this.computePageSize();
			this.fetchPage()
		}
		
		public function computeTo():int {
			return firstRowOnPage+rowsPerPage-1
		}
		public function computeFrom():int {
			return this.firstRowOnPage
		}
		
		public function reset():void {
			trace(this+">reset");
			firstRowOnPage = 0;
			lastRowOnPage = 0;
			rowsPerPage = 10;
			totalRows = 0;
		}	

		public function fetchPage():void {
			var event:PageNavigationEvent = new PageNavigationEvent("refresh")
			this.dispatchEvent(event)
		}

		public function dataReceived(data:XML):void {			
			_pageLoaded.call(this,data);
			// update pages on the navigation bar
			_bar.updatePageControlsByRows(firstRowOnPage,rowsPerPage,totalRows);
		}
		
		override public function toString():String {
			return "PageNavigator>>firstRowOnPage,rowsPerPage,totalRows:" + firstRowOnPage + "," + rowsPerPage + "," + totalRows;
		}
		
		public function refresh():void {
    		trace("PageNavigator>>refresh");
    		this.rowsPerPage = this.computePageSize();
    		this.fetchPage();
    	}
    	private function computePageSize():Number {
			return Math.round(_dataGrid.height / Math.max(_dataGrid.rowHeight,preferredRowHeight)) - 1 - 1; // header & partly visible bottom row
		}  
		public function updatePageInfo(from:Number,to:Number,total:Number):void {
			firstRowOnPage = from
			lastRowOnPage = to
			totalRows = total
		}
    	public function updateSortInfo(sortkey:String,sortmethod:String):void {
    		sortkey = sortkey
    		sortmethod = sortmethod
    	}		 			
	}
}
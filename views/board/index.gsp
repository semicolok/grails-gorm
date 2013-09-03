<!DOCTYPE html>
<html>
	<head>
	<title>JK's Board</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style type="text/css">body {padding-top: 60px; padding-bottom: 40px;}</style>
	<g:javascript library="jquery" />
	<g:javascript library="bootstrap" />
	<r:layoutResources />
	<script type="text/javascript">
		$(document).ready(function(){
			var url = 'board';

			var resetForm = function(){
				$("#id").val('');
				$("#title").val('');
				$("#writer").val('');
				$("#content").val('');
				};
				
			var load = function(){
				$.getJSON(url, function(json) {
					   var boardList = json.boardList;
					   
					   var page='<ul>';
					   for (var i=0; i < boardList.length; i++) {
						   page+='<li>' + boardList[i].id +' || ' + boardList[i].title +' || ' + boardList[i].content;

						   page += '<a href="#" class="remove" boardId="' + boardList[i].id + '"> X</a> | ';
						   page += '<a href="#" class="update" boardId="' + boardList[i].id + '">U</a> </li>';
						  }
					   page+='</ul>';

						$('#boardSection').html(page);

					   
					 });
				};
								
			var save = function(){
				var params = {
						'_method': 'PUT',
						id: $("#id").val(),
						title : $("#title").val(),
						writer : $("#writer").val(),
						content : $("#content").val()
						}
				$.ajax({
					type: "POST",
					url: url,
					data: params,
					dataType: "json",
					success: function(json){},
					complete: function(){ 
						resetForm();
						load();
						}
					});
				};

			var remove = function(boardId){
				$.post(url, {'_method': 'DELETE', id: boardId}, function(data){
						load();
						if(data.result){
							alert('Delete Success!')
						}
					});
				};

			var update = function(boardId){
				$.getJSON(url, { id: boardId}, function(json) {
					var board = json.board;
					$("#id").val(board.id);
					$("#title").val(board.title);
					$("#writer").val(board.writer);
					$("#content").val(board.content);			   
					 });
					};
			
			$('#saveBt').click(function(){
				save();
				});

			$('#boardSection').click(function(event){
				var target = $(event.target);
				
				if(target.hasClass('remove')){
					remove(target.attr('boardId'));
				}else if(target.hasClass('update')){
					update(target.attr('boardId'));
				}
			});

			load();
			});
	</script>
	</head>
	<body>
	
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
				  <span class="icon-bar"></span>
				  <span class="icon-bar"></span>
				  <span class="icon-bar"></span>
				</a>
				
				<a class="brand" href="#">jk's board.</a>
				
				<div class="nav-collapse collapse">
					<ul class="nav">
						<li><a href="#">Home</a></li>
						<li class="active"><a href='<c:url value="/w/main"/>'>Board</a></li>
						<li class="active"><a href="#" id="editorBt" data-toggle="modal"><i class="icon-pencil icon-white"></i></a></li>
						
					</ul>		  
				</div>
			</div>
		</div>
	</div>
	
	<form class="form-horizontal">
			<input type="hidden" id="id" value="" />
			
			<div class="control-group">
				<label class="control-label" for="title">title</label>
				<div class="controls">
					<input type="text" name="title" id="title" placeholder="title" />
				</div>
			</div>
			
			<div class="control-group">
				<label class="control-label" for="writer">writer</label>
				<div class="controls">
					<input type="text" name="writer" id="writer" placeholder="writer" />
				</div>
			</div>
			
			<div class="control-group">
				<div class="controls">
					<textArea name="content" id="content" placeholder="content"></textArea>
				</div>
			</div>
			
			<div class="control-group">
				<div class="controls">
					<a class="btn btn-primary" id="saveBt">Save</a>
				</div>
			</div>
		</form>
	 <div class="container">
	 	<div id="boardSection"></div>
<%--	 <ul>--%>
<%--			<g:each var="board" in="${boardList }">--%>
<%--			<li>${board.title }</li>	--%>
<%--			</g:each>--%>
<%--	</ul>--%>
    </div>
    
	</body>
	
</html>

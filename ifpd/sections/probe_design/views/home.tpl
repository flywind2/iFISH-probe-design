% include(vpath + 'header.tpl')

<!-- header -->
<div class="row">
	<div id="main" class="col col-xl-6 offset-xl-3 col-lg-12">

		<h1 id="title">
			iFISH Probe Designer
		</h1>
		
		%if breadcrumbs:
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				%if not type(None) == type(menu_template):
					%include(menu_template)
				%end
				<li class="breadcrumb-item"><a href="/">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">Design</li>
			</ol>
		</nav>
		%end

		<div id="abstract">
			Here you can <u>design</u> new single probes or spotting probes. Go to the <a href="javascript:$('a[aria-controls=\'new_query\']').click();">Single Probe</a> tab to design one probe in a region of interest. Instead, to query for a number of probes in a single region of interest use <a href="javascript:$('a[aria-controls=\'new_multi_query\']').click();">Spotting Probe</a>. In the <a href="javascript:$('a[aria-controls=\'databases\']').click();">Databases</a> tab you can scroll through the available databases. To go to a previously ran query, use the <a href="javascript:$('a[aria-controls=\'search\']').click();">search</a> tool. You can also check how many queries are currently in the <a href="javascript:$('a[aria-controls=\'queue\']').click();">Queue</a>. More details in the <a href="https://ggirelli.github.io/iFISH-probe-design/" target="_help">help</a> page.
		</div>

		<div class="row">
			<!-- main panel -->
			<div class="col col-12">
				<div id="designer" class="card">
					<div class="card-header card-outline-primary">

						<!-- Nav tabs -->
						<ul class="nav nav-tabs card-header-tabs">
							<li role="presentation" class="nav-item">
								<a class="nav-link active" href="#new_query" aria-controls="new_query" role="tab" data-toggle="tab">Single probe</a>
							</li>
							<li role="presentation" class="nav-item">
								<a class="nav-link" href="#new_multi_query" aria-controls="new_multi_query" role="tab" data-toggle="tab">Spotting Probe</a>
							</li>
							<li role="presentation" class="nav-item">
								<a class="nav-link" href="#databases" aria-controls="databases" role="tab" data-toggle="tab">Databases</a>
							</li>
							<li role="presentation" class="nav-item">
								<a class="nav-link" href="#queue" aria-controls="queue" role="tab" data-toggle="tab">Queue</a>
							</li>
							<li role="presentation" class="nav-item">
								<a class="nav-link" href="#search" aria-controls="search" role="tab" data-toggle="tab"><span class="fas fa-search"></span></a>
							</li>
							<li rolw="presentation" class="nav-item">
								<a class="nav-link" href="https://ggirelli.github.io/iFISH-probe-design/interface/" target="_new" data-toggle="tooltip" data-placement="top" title="Help">
									<span class="fas fa-info-circle"></span>
								</a>
							</li>
							<li rolw="presentation" class="nav-item">
								<a class="nav-link" href="http://genome.ucsc.edu/cgi-bin/hgTracks" target="_new" data-toggle="tooltip" data-placement="top" title="Genome Browser">
									<span class="fas fa-dna"></span>
								</a>
							</li>
						</ul>

					</div>

					<!-- Tab panes -->
					<div class="card-block">
						<div class="tab-content">

							<div role="tabpanel" class="tab-pane active overflow" id="new_query">
								% include(vpath + 'single_query_form.tpl')
							</div>

							<div role="tabpanel" class="tab-pane overflow" id="new_multi_query">
								% include(vpath + 'spotting_query_form.tpl')
							</div>

							<div role="tabpanel" class="tab-pane overflow" id="databases">
								% include(vpath + 'databases.tpl')
							</div>

							<div role="tabpanel" class="tab-pane overflow" id="queue">
								<ul class="list-group"></ul>
								<p class="mt-3 text-right"><a href="javascript:getQueueStatus('#queue>.list-group');" class="fas fa-redo text-decoration-none"></a></p>
							</div>
							<script type="text/javascript">
								getQueueStatus = function(target) {
									$.get('{{app_uri}}queueStatus', {}, function(data) {
										$(target).children().remove();
										if ( 0 == data['queue'].length ) {
											$(target).prepend($('<li class="list-group-item">The queue is currently empty.</li>'));
											return
										}
										for (var i = data['queue'].length - 1; i >= 0; i--) {
											taskID = data['queue'][i];
											$(target).prepend($('<li class="list-group-item"><b>' + (i+1) + ':</b> ' + taskID + '</li>'));
										}
									}, 'json');
								}
								getQueueStatus('#queue>.list-group');
							</script>

							<div role="tabpanel" class="tab-pane overflow" id="search">
								<form action="javascript:document.location='{{app_uri}}q/'+$('#query_id_search')[0].value;">
									<input id="query_id_search" class="form-control" type="text" name="search_query_by_id" placeholder="Insert your query ID and press enter." />
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>

% include(vpath + 'footer.tpl')

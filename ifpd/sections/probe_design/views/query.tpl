%import numpy as np
%import os
%import time
%include(vpath + 'header.tpl')

<!-- header -->
<div class="row">
	<div id="main" class="col col-xl-6 offset-xl-3 col-lg-12">

		<h1 id="title">
			Query
		</h1>
		
		%if breadcrumbs:
		<nav aria-label="breadcrumb">
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/">Home</a></li>
				<li class="breadcrumb-item"><a href="/probe-design/">Design</a></li>
				<li class="breadcrumb-item break-all" aria-current="page">Query: {{query['id']}}</li>
			</ol>
		</nav>
		%end

		%if not 'hidden_bookmark_alter' in query.keys():
		<div id="bookmark_alert" class="alert alert-dark" role="alert">
			<b>Save the link to this page to be able get back here!</b> Or, <a id="query_id_copy_trigger" class="text-decoration-none" href="#" data-clipboard-text="{{query['id']}}">copy your query ID</a> and then use the "search a query" tool in the design page to get back here.<a class="float-right text-dark text-decoration-none" href="javascript:jQuery.post('{{app_uri}}hide_alert', {query_id:'{{query['id']}}'}, function(data) { document.location=document.location; });"><i class="fas fa-times"></i></a>
		</div>
		<script type="text/javascript">
			var clipboard = new ClipboardJS('#query_id_copy_trigger');
			clipboard.on('success', function(e) {
			    $('#bookmark_alert').append(
			    	$('<div class="alert alert-success text-center clipboardJSresponse" role="alert">Copied!</div>')
			    		.css({'position':'fixed', 'top':'1em', 'left':'1em', 'right':'1em'}).delay(2000).fadeOut())
			    e.clearSelection();
			});

			clipboard.on('error', function(e) {
			    $('#bookmark_alert').append(
			    	$('<div class="alert alert-danger text-center clipboardJSresponse" role="alert">Something went wrong.</div>')
			    		.css({'position':'fixed', 'top':'1em', 'left':'1em', 'right':'1em'}).delay(2000).fadeOut())
			    alert("not copied")
			});
		</script>
		%end

		%if query['status'] == 'queued':
		%if time.time() - float(query['time']) > queryTimeout:
			<div class="alert alert-danger" role="alert">
				This query timed out (queried@{{query['isotime']}}). Please, try again or contact the <a href="mailto:{{admin_email}}">server admin</a>.
			</div>
		%else:
			<div class="alert alert-warning" role="alert">
				<a class="text-warning" href="{{app_uri}}q/{{query['id']}}" data-toggle="tooltip" data-placement="top" title="Refresh"><span class="fas fa-redo-alt"></span></a>&nbsp;
				This query was queued at {{query['isotime']}}. This page will refresh automatically every 10 seconds.
			</div>
			<meta http-equiv="refresh" content="10; URL="{{app_uri}}q/{{query['id']}}">
		%end
		%end
		%if query['status'] == 'running':
		%if time.time() - float(query['start_time']) > queryTimeout:
			<div class="alert alert-danger" role="alert">
				This query timed out (started@{{query['start_isotime']}}). Please, try again or contact the <a href="mailto:{{admin_email}}">server admin</a>.
			</div>
		%else:
			<div class="alert alert-warning" role="alert">
				<a class="text-warning" href="{{app_uri}}q/{{query['id']}}" data-toggle="tooltip" data-placement="top" title="Refresh"><span class="fas fa-redo-alt"></span></a>&nbsp;
				This query has been running since {{query['start_isotime']}} ({{"%.3f" % (time.time() - float(query['start_time']))}} seconds), after being queued for {{"%.3f" % (float(query['start_time']) - float(query['time']))}} seconds. This page will refresh automatically every 5 seconds.
			</div>
			<meta http-equiv="refresh" content="5; URL="{{app_uri}}q/{{query['id']}}">
		%end
		%end
		%if query['status'] == 'done':
			<div class="alert alert-success" role="alert">
				This query was completed at {{query['done_isotime']}}, after running for {{"%.3f" % (float(query['done_time']) - float(query['start_time']))}} seconds.
			</div>
		%end

		<div id="abstract">
			<h4>{{query['name']}}</h4>
			<h6 class="isotime">{{query['isotime']}}</h6>
			{{query['description']}}
		</div>

		%if query['status'] == 'done':
		<div class="container-fluid p-0"><div class="card mb-3">
			<div class="card-header border-primary">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs card-header-tabs" role="tablist">
					<li role="presentation" class="nav-item"><a class="nav-link active" href="#table_tab" aria-controls="table_tab" role="tab" data-toggle="tab">Table</a></li>
					<li role="presentation" class="nav-item"><a class="nav-link" href="#comparison_tab" aria-controls="comparison_tab" role="tab" data-toggle="tab">Figures</a></li>
				</ul>
			</div>

			<div class="tab-content card-body">
				<div role="tabpanel" class="tab-pane active overflow" id="table_tab">
					%if query['type'] == 'single':
					<p>Showing top {{query['max_probes']}}/{{query['candidate_table'].shape[0]}} probe candidates.</p>

					<table id="candidate_table" class="table table-striped table-sm">
						<thead class="thead-dark">
							<tr>
								<th>id</th>
								%for column in query['candidate_table'].columns:
								<th>{{column}}</th>
								%end
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							%for rowi in range(min(query['candidate_table'].shape[0], int(query['max_probes']))):
								<tr>
									<td>{{rowi}}</td>
									%for coli in range(query['candidate_table'].shape[1]):
									<td>
										%if np.float64 == type(query['candidate_table'].iloc[rowi, coli]):
										{{'%.6f'% query['candidate_table'].iloc[rowi, coli]}}
										%else:
										{{query['candidate_table'].iloc[rowi, coli]}}
										%end
									</td>
									%end
									<td>
										<a href="{{app_uri}}q/{{query['id']}}/c/{{rowi}}" class="fas fa-external-link-square-alt" data-toggle="tooltip" data-placement="top" title="Open candidate #{{rowi}}"></a>&nbsp;
										<a href="{{app_uri}}q/{{query['id']}}/c/{{rowi}}/download/" target="_download" class="fas fa-download" data-toggle="tooltip" data-placement="top" title="Download candidate #{{rowi}}"></a>
									</td>
								</tr>
							%end
						</tbody>
					</table>

					%else:

					<p>Built {{query['candidate_table'].shape[0]}} probe set candidates.</p>

					<table id="candidate_table" class="table table-striped table-sm">
						<thead class="thead-dark">
							<tr>
								<th>id</th>
								%for column in query['candidate_table'].columns:
								<th>{{column}}</th>
								%end
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							%for rowi in range(query['candidate_table'].shape[0]):
								<tr>
									<td>{{rowi}}</td>
									%for coli in range(query['candidate_table'].shape[1]):
									<td>
										%if np.float64 == type(query['candidate_table'].iloc[rowi, coli]):
										{{'%.6f'% query['candidate_table'].iloc[rowi, coli]}}
										%else:
										{{query['candidate_table'].iloc[rowi, coli]}}
										%end
									</td>
									%end
									<td>
										<a href="{{app_uri}}q/{{query['id']}}/cs/{{rowi}}" class="fas fa-external-link-square-alt" data-toggle="tooltip" data-placement="top" title="Open candidate #{{rowi}}"></a>&nbsp;
										<a href="{{app_uri}}q/{{query['id']}}/cs/{{rowi}}/download/" target="_download" class="fas fa-download" data-toggle="tooltip" data-placement="top" title="Download candidate #{{rowi}}"></a>
									</td>
								</tr>
							%end
						</tbody>
					</table>

					%end
				</div>

				<div role="tabpanel" class="tab-pane overflow" id="comparison_tab">
					%if query['type'] == 'single':

					<table id="candidate_figure_table" class="table table-sm">
						<thead class="thead-dark">
							<tr>
								<th>id</th>
								<th>Probe position</th>
								<th>Oligo distance</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							%for rowi in range(min(query['candidate_table'].shape[0], int(query['max_probes']))):
								<tr>
									<td>{{rowi}}</td>
									<td>
										<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/c/{{rowi}}/images/window.png" alt="Candidate #{{rowi}}, window" />
									</td>
									<td>
										<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/c/{{rowi}}/images/oligo.png" alt="Candidate #{{rowi}}, oligo" />
									</td>
									<td>
										<a href="{{app_uri}}q/{{query['id']}}/c/{{rowi}}" class="fas fa-external-link-square-alt" data-toggle="tooltip" data-placement="top" title="Open candidate #{{rowi}}"></a>&nbsp;
										<a href="{{app_uri}}q/{{query['id']}}/c/{{rowi}}/download/" target="_download" class="fas fa-download" data-toggle="tooltip" data-placement="top" title="Download candidate #{{rowi}}"></a>
									</td>
								</tr>
							%end
						</tbody>
					</table>

					%else:

					<table id="candidate_figure_table" class="table table-sm">
						<thead class="thead-dark">
							<tr>
								<th>id</th>
								<th>Probe position</th>
								<th>Probe distance</th>
								<th>Options</th>
							</tr>
						</thead>
						<tbody>
							%for rowi in range(query['candidate_table'].shape[0]):
								<tr>
									<td>{{rowi}}</td>
									<td>
										<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/cs/{{rowi}}/images/windows.png" alt="Candidate #{{rowi}}, windows" />
									</td>
									<td>
										<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/cs/{{rowi}}/images/distr.png" alt="Candidate #{{rowi}}, distr" />
									</td>
									<td>
										<a href="{{app_uri}}q/{{query['id']}}/cs/{{rowi}}" class="fas fa-external-link-square-alt" data-toggle="tooltip" data-placement="top" title="Open candidate #{{rowi}}"></a>&nbsp;
										<a href="{{app_uri}}q/{{query['id']}}/cs/{{rowi}}/download/" target="_download" class="fas fa-download" data-toggle="tooltip" data-placement="top" title="Download candidate #{{rowi}}"></a>
									</td>
								</tr>
							%end
						</tbody>
					</table>

					%end
				</div>
			</div>
		</div></div>
		%end

		<div class="row">
			<div class="col col-xl-6 col-12">
				<div class="card border-primary mb-3">
					<div class="card-body">
						<h3 class="card-title">Query settings</h3>
						<ul class="list-group list-group-flush query_settings">
							<li class="list-group-item border-primary">
								<b>Name:</b> {{query['name']}}
							</li>
							<li class="list-group-item border-primary">
								<b>Time:</b> {{query['isotime']}}
							</li>
							<li class="list-group-item border-primary">
								<b>Type:</b> {{query['type']}}
							</li>
							<li class="list-group-item border-primary">
								<b>Database:</b> {{query['db']}}
							</li>
							<li class="list-group-item border-primary">
								<b># oligos per probe:</b> {{query['n_oligo']}}
							</li>
							<li class="list-group-item border-primary">
								<b>Feature #1 threshold:</b> {{query['threshold']}}
							</li>
							%if query['type'] == "single":
							<li class="list-group-item border-primary">
								<b>Max # output probes:</b> {{query['max_probes']}}
							</li>
							%else:
							<li class="list-group-item border-primary">
								<b># of probes:</b> {{query['n_probes']}}
							</li>
							<li class="list-group-item border-primary">
								<b>Windows shift:</b> {{query['window_shift']}}
							</li>
							%end
							<li class="list-group-item border-primary">
								<b>Feature order:</b> {{query['f1']}}, {{query['f2']}}, {{query['f3']}}
							</li>
						</ul>
					</div>
				</div>
			</div>

			<div class="col col-xl-6 col-12">
				<div class="card border-secondary mb-3">
					<div class="card-body">
						<h3 class="card-title">Cmd</h3>
						<pre class="ws_wrap m-0" style="max-height: 25em;">{{query['cmd']}}</pre>
					</div>
				</div>
			</div>

			<div class="col col-12">
				<div class="card border-secondary mb-3">
					<div class="card-body">
						<h3 class="card-title">Log</h3>
						%if os.path.isdir(os.path.join(queryRoot, query['id'])):
						%with open(os.path.join(queryRoot, query['id'], 'log')) as IH:
						<pre id="log_textarea" class="ws_wrap m-0" style="max-height: 25em;">{{"".join(IH.readlines())}}</pre>
						%end
						%else:
						<pre id="log_textarea" class="ws_wrap m-0" style="max-height: 25em;">Log not found.</pre>
						%end
					</div>
				</div>
			</div>
		</div>

		%if 'done' == query['status']:
		<div class="row"><div class="col col-12">
			<div class="card"><div class="card-body">
				<a href="{{app_uri}}q/{{query['id']}}/download/" target="_download" class="text-decoration-none">
					<button class="btn btn-lg btn-block btn-success"><span class="fas fa-download"></span>&nbsp;Download</button>
				</a>
				<small><b>Note! </b>The first time you click this button, it might take a few moments to generate the compressed folder.</small>
			</div></div>
		</div></div>
		%else:
		<script type="text/javascript">
		$(document).ready(function(){
		    var $textarea = $('#log_textarea');
		    $textarea.scrollTop($textarea[0].scrollHeight);
		});
		</script>
		%end

	</div>
</div>

% include(vpath + 'footer.tpl')
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
				<li class="breadcrumb-item"><a href="{{app_uri}}q/{{query['id']}}">Query: {{query['id']}}</a></li>
				<li class="breadcrumb-item"><a href="{{app_uri}}q/{{query['id']}}/cs/{{candidate['id']}}">Candidate: {{candidate['id']}}</a></li>
				<li class="breadcrumb-item" aria-current="page">Probe: {{probe['id']}}</li>
			</ol>
		</nav>
		%end
		
		<div class="container-fluid p-0"><div class="card mb-3">
			<div class="card-header">Probe #{{probe['id']}}</div>
			<div class="card-body">
				<table>
					<tbody>
						<tr>
							<td colspan="3">
								<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/cs/{{candidate['id']}}/p/{{probe['id']}}/images/probe.png" alt="Probe #{{probe['id']}}, probe" />
							</td>
						</tr>
						<tr>
							<td>
								<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/cs/{{candidate['id']}}/p/{{probe['id']}}/images/window.png" alt="Probe #{{probe['id']}}, window" />
							</td>
							<td>
								<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/cs/{{candidate['id']}}/p/{{probe['id']}}/images/oligo.png" alt="Probe #{{probe['id']}}, oligo" />
							</td>
							<td>
								<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/cs/{{candidate['id']}}/p/{{probe['id']}}/images/distance.png" alt="Probe #{{probe['id']}}, distance" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div></div>
	
		<div class="row">
			<div class="col col-6"><div class="card border-primary">
				<div class="card-body">
					<h3 class="card-title">Details</h3>
					<ul class="list-group list-group-flush candidate_settings">
						<li class="list-group-item border-primary">
							<b>Region: </b>{{probe['chrom']}}:{{probe['chromstart']}}-{{probe['chromend']}}
						</li>
						<li class="list-group-item border-primary">
							<b># oligos: </b>{{probe['noligo']}}
						</li>
						<li class="list-group-item border-primary">
							<b>Centrality: </b>{{probe['centrality']}}
						</li>
						<li class="list-group-item border-primary">
							<b>Size: </b>{{probe['size']}}
						</li>
						<li class="list-group-item border-primary">
							<b>Spread: </b>{{probe['spread']}}
						</li>
					</ul>
				</div>
			</div></div>
			<div class="col col-6"><div class="card">
				<div class="card-body row">
					<h3 class="card-title col col-12">Download as...</h3>
					<a href="{{app_uri}}q/{{query['id']}}/cs/{{candidate['id']}}/p/{{probe['id']}}/documents/probe_{{probe['id']}}.fasta/download/" target="_download" class="col col-6 text-decoration-none"><button class="btn btn-info btn-block btn-lg"><span class="fas fa-dna"></span>&nbsp;Fasta</button></a>
					<a href="{{app_uri}}q/{{query['id']}}/cs/{{candidate['id']}}/p/{{probe['id']}}/documents/probe_{{probe['id']}}.bed/download/" target="_download" class="col col-6 text-decoration-none"><button class="btn btn-info btn-block btn-lg"><span class="fas fa-bed"></span>&nbsp;Bed</button></a>
					<a href="{{app_uri}}q/{{query['id']}}/cs/{{candidate['id']}}/p/{{probe['id']}}/download/" target="_download" class="col col-12 text-decoration-none mt-3"><button class="btn btn-info btn-block btn-lg"><span class="fas fa-file-archive"></span>&nbsp;Zip</button></a>
				</div>
			</div></div>
		</div>

	</div>
</div>

% include(vpath + 'footer.tpl')
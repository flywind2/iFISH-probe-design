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
				%if not type(None) == type(menu_template):
					%include(menu_template)
				%end
				<li class="breadcrumb-item"><a href="/">Home</a></li>
				<li class="breadcrumb-item"><a href="/probe-design/">Design</a></li>
				<li class="breadcrumb-item"><a href="{{app_uri}}q/{{query['id']}}">Query: {{query['id']}}</a></li>
				<li class="breadcrumb-item" aria-current="page">Candidate: {{candidate['id']}}</li>
			</ol>
		</nav>
		%end
		
		<div class="container-fluid p-0"><div class="card mb-3">
			<div class="card-header">Candidate #{{candidate['id']}}</div>
			<div class="card-body">
				<table>
					<tbody>
						<tr>
							<td colspan="3">
								<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/c/{{candidate['id']}}/images/probe.png" alt="Candidate #{{candidate['id']}}, probe" />
							</td>
						</tr>
						<tr>
							<td>
								<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/c/{{candidate['id']}}/images/window.png" alt="Candidate #{{candidate['id']}}, window" />
							</td>
							<td>
								<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/c/{{candidate['id']}}/images/oligo.png" alt="Candidate #{{candidate['id']}}, oligo" />
							</td>
							<td>
								<img class="img-fluid" src="{{app_uri}}q/{{query['id']}}/c/{{candidate['id']}}/images/distance.png" alt="Candidate #{{candidate['id']}}, distance" />
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
							<b>Region: </b>{{candidate['chrom']}}:{{candidate['chromstart']}}-{{candidate['chromend']}}
						</li>
						<li class="list-group-item border-primary">
							<b># oligos: </b>{{candidate['noligo']}}
						</li>
						<li class="list-group-item border-primary">
							<b>Centrality: </b>{{candidate['centrality']}}
						</li>
						<li class="list-group-item border-primary">
							<b>Size: </b>{{candidate['size']}}
						</li>
						<li class="list-group-item border-primary">
							<b>Homogeneity: </b>{{candidate['homogeneity']}}
						</li>
					</ul>
				</div>
			</div></div>
			<div class="col col-6"><div class="card">
				<div class="card-body row">
					<h3 class="card-title col col-12">Download as...</h3>
					<a href="{{app_uri}}q/{{query['id']}}/c/{{candidate['id']}}/documents/candidate_{{candidate['id']}}.fasta/download/" target="_download" class="col col-6 text-decoration-none"><button class="btn btn-info btn-block btn-lg"><span class="fas fa-dna"></span>&nbsp;Fasta</button></a>
					<a href="{{app_uri}}q/{{query['id']}}/c/{{candidate['id']}}/documents/candidate_{{candidate['id']}}.bed/download/" target="_download" class="col col-6 text-decoration-none"><button class="btn btn-info btn-block btn-lg"><span class="fas fa-bed"></span>&nbsp;Bed</button></a>
					<a href="{{app_uri}}q/{{query['id']}}/c/{{candidate['id']}}/download/" target="_download" class="col col-12 text-decoration-none mt-3"><button class="btn btn-info btn-block btn-lg"><span class="fas fa-file-archive"></span>&nbsp;Zip</button></a>
				</div>
			</div></div>
		</div>

	</div>
</div>

% include(vpath + 'footer.tpl')
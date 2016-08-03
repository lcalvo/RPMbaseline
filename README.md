# RPMbaseline
Perl code to report rpm different installations on exadata compute nodes
1.- using dcli we connect to all compute nodes we want, specified under the groupComputeNodes, and with a particular query format we obtain all the rpm installed in one single file.
2.- we have a template of a vanilla rpm install on exadata. We call it 0KnownList
3.- the goal of this report is to present an spreadsheet with the list of rpms across the compute nodes using versions installed

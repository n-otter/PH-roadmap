# PH-roadmap

# Project founder:

Nina Otter (For contact information, see <a href="http://people.maths.ox.ac.uk/otter/"> here </a>.)

# Description

This project was created to host data sets and scripts used in the paper [1] and the supplementary information.







# Software for PH

<p>


<td align="center" valign="middle" width="20%"><a href="#intro">Brief introduction</a></td>
<td align="center" valign="middle" width="20%"><a href="#complexes">By complexes</a></td>
<td align="center" valign="middle" width="20%"><a href="#language">By language</a></td>
<td align="center" valign="middle" width="20%"><a href="#statistics">Statistical tools</a></td>



<a name="intro">&nbsp;</a><br>
<h3> Brief Introduction </h3>

If you are new to the computation of persistent homology a good idea is to start with javaPlex, which is the new library of the Plex family:


<ul>

<p>
<li>
<a href="http://appliedtopology.github.io/javaplex/"> javaPlex</a>

<p>
<li>
<a href="http://www.math.duke.edu/~hadams/jplex/index.html"> jPlex</a>

<p>
<li>
<a href="http://mii.stanford.edu/research/comptop/programs/"> Plex</a>
</ul>


After that you could try out Perseus, which implements Morse theoretic reductions to reduce the size of the complex:

<ul>
<p>
<li>
<a href="http://www.sas.upenn.edu/~vnanda/perseus/"> Perseus</a>

</ul>

<p>
If you are familiar with R you might want to try out these two libraries:
<ul>
<p>
<li>
<a href="http://rpackages.ianhowson.com/cran/phom/man/phom-package.html"> pHom</a>


<p>
<li>
<a href="https://cran.r-project.org/web/packages/TDA/"> TDA</a>


</ul>

....and if you are familiar with GAP  this one:

<p>
<ul>
<li>
<a href="http://www-circa.mcs.st-and.ac.uk/~mik/persistence/"> GAP Persistence</a>
</ul>
</p>


The following is a powerful toolbox of algorithms for the computation of barcodes from the boundary matrix (the first package to implement parallel computation in a shared setting):

<ul>
<li>
<a href="https://code.google.com/p/phat/"> PHAT</a>
</ul>

....if you do not want to compute the boundary matrix yourself, you can use its spin-off library (which implements algorithms for parallel computations in a distributed setting):
<ul>
<p>
<li>
<a href="https://code.google.com/p/dipha/"> DIPHA</a>
</ul>

<p>
Another powerful software is this:
<p>
<ul>
<li>
<a href="https://project.inria.fr/gudhi/software/"> GUDHI</a>
</ul>


This is the only software to implement, among other things, the computation of PH with the &#268;ech complex, and vineyards:

<ul>
<p>
<li>
<a href="http://www.mrzv.org/software/dionysus/"> Dionysus</a>
</ul>
<p>

...while the following library implements, among other things, a <a href="http://arxiv.org/abs/1407.2275">parallel computation of homology</a> based on the Mayer-Vietoris principle and the computation of PH over finite fields:


<ul>
<p>
<li>
<a href="http://ctl.appliedtopology.org/">CTL</a>
</ul>
<p>

The following is a module for the <a href="https://www-fourier.ujf-grenoble.fr/~sergerar/Kenzo/">Kenzo</a> library which implements computation of PH in a more general setting, i.e. with integer coefficients and for infinite spaces (provided their homology is <a href="https://www-fourier.ujf-grenoble.fr/~sergerar/Papers/Constructive-AT.pdf">effective</a>):
<ul>
<p>
<li>
 <a href="http://www.unirioja.es/cu/anromero/persistent-homology.zip"> Kenzo module for PH</a> (see the companion <a href="http://arxiv.org/pdf/1403.7086v2.pdf"> preprint</a> for instructions)
</ul>

<p class="bottom-three">
</p>





Finally some more libraries:
</p>


....to do statistics on persistence diagrams:


<ul>
<p>
<li>
<a href="https://www.math.upenn.edu/~dlotko/persistenceLandscape.html"> The Persistence Landscape Toolbox</a>
</p>
</ul>

....for simplicial maps:

<ul>

<p>
<li>
<a href="http://web.cse.ohio-state.edu/~tamaldey/SimpPers/SimpPers-software/"> SimpPers</a>
</p>
</ul>

....to compute the weight rank clique filtration for networks:


<ul>
<p>
<li>
<a href="http://cuda.unicam.it/jHoles"> jHoles</a>
</p>
</ul>

....and its older version:

<ul>
<p>
<li>
<a href="http://lordgrilo.github.io/Holes/"> Holes </a>
</p>
</ul>

....for fast computation of PH with alpha complexes in 1-D:
<ul>

<li>
<a href="http://kurlin.org/projects/persistent-skeletons.php"> HOPES</a>
</ul>


<a name="complexes">&nbsp;</a><br>
<h3> By complexes </h3>

<a name="language">&nbsp;</a><br>
<h3> By language </h3>

<a name="statistics">&nbsp;</a><br>
<h3> Statistical tools </h3>

# References
[1] A roadmap for the computation of persistent homology. N. Otter, M. Porter, U. Tillmann, P. Grindrod, H. Harrington

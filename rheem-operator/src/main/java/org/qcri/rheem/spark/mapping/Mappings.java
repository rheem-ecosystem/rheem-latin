package org.qcri.rheem.spark.mapping;

import org.qcri.rheem.core.mapping.Mapping;
import org.qcri.rheem.spark.mapping.graph.PageRankMapping;

import java.util.Arrays;
import java.util.Collection;

public class Mappings {

    public static Collection<Mapping> BASIC_MAPPINGS = Arrays.asList(
            new Mapping[]{
                    new TextFileSourceMapping(),
                    new TextFileSinkMapping(),
                    new MapMapping(),
                    new MapPartitionsMapping(),
                    new ReduceByMapping(),
                    new CollectionSourceMapping(),
                    new LocalCallbackSinkMapping(),
                    new GlobalReduceMapping(),
                    new MaterializedGroupByMapping(),
                    new GlobalMaterializedGroupMapping(),
                    new FlatMapMapping(),
                    new CountMapping(),
                    new DistinctMapping(),
                    new SortMapping(),
                    new FilterMapping(),
                    new UnionAllMapping(),
                    new IntersectMapping(),
                    new CartesianMapping(),
                    new JoinMapping(),
                    new LoopMapping(),
                    new DoWhileMapping(),
                    new RepeatMapping(),
                    new SampleMapping(),
                    new ZipWithIdMapping(),
                    new LimitMapping()
            });
    public static Collection<Mapping> GRAPH_MAPPINGS = Arrays.asList(new Mapping[]{new PageRankMapping()});

    public Mappings() {
    }
}
use gdal::config::set_config_option;
use gdal::{Dataset, vector::FieldValue, vector::LayerAccess};

fn main() {
    // Чтобы OSM драйвер не «захлёбывался» буфером других слоёв.
    set_config_option("OGR_INTERLEAVED_READING", "YES").expect("can't set option");

    let dataset = Dataset::open("maps/sample.osm.pbf").expect("can't open file");
    let mut layer = dataset
        .layer_by_name("points")
        .expect("can't get layer by name \"lines\"");
    // for layers in dataset.layers() {
    //     print!("{}\n", layers.name());
    // }

    for feature in layer.features() {
        for (name, value) in feature.fields() {
            print!("{} --- {:?}\n", name, value);

            if let Some(v) = value {
                match v {
                    FieldValue::StringValue(s) => println!("{} = {}", name, s),
                    FieldValue::IntegerValue(i) => println!("{} = {}", name, i),
                    FieldValue::RealValue(f) => println!("{} = {}", name, f),
                    _ => {}
                }
            }
        }
    }
}

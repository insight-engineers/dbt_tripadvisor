import dateutil
import pandas


def model(dbt, session):
    df = dbt.ref("base_tripadvisor__queries").to_df()

    ## TODO: Perform some transformations on the data
    return df

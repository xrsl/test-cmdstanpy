import os
from cmdstanpy import cmdstan_path, CmdStanModel

# specify locations of Stan program file and data
stan_file = os.path.join(cmdstan_path(), "examples", "bernoulli", "bernoulli.stan")
data_file = os.path.join(cmdstan_path(), "examples", "bernoulli", "bernoulli.data.json")

# instantiate a model; compiles the Stan program by default
model = CmdStanModel(stan_file=stan_file)

# obtain a posterior sample from the model conditioned on the data
fit = model.sample(chains=4, data=data_file)

# summarize the results (wraps CmdStan `bin/stansummary`):
fit.summary()

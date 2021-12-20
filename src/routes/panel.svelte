<script>
  import {
    Tile,
    Form,
    TextInput,
    PasswordInput,
    Button,
    Row,
    Column,
    InlineLoading,
    Grid,
  } from 'carbon-components-svelte';
  import ArrowRight16 from 'carbon-icons-svelte/lib/ArrowRight16';

  let email = '';
  let password = '';
  let invalidCreds = false;
  let loading = false;
  let status = 'active';
  let description = 'Signin in...';

  const onSubmit = (e) => {
    loading = true;
  };
</script>

<div id="login-container">
  <Tile>
    <Grid padding noGutter>
      <Row>
        <Column>
          <h1>Admin Sign In</h1>
        </Column>
      </Row>
      <Row>
        <Column>
          <Form on:submit={onSubmit}>
            <TextInput
              labelText="Email"
              placeholder="Enter your email"
              invalidText="Incorrect email or password"
              bind:invalid={invalidCreds}
              bind:value={email}
              on:keydown={() => {
                invalidCreds = false;
              }}
              style="margin-bottom: 1.5rem"
            />
            <PasswordInput
              labelText="Password"
              placeholder="Enter your password"
              bind:invalid={invalidCreds}
              bind:value={password}
            />
            <div style="margin-top: 1.5rem">
              {#if !loading}
                <Button type="submit" style="text-align: right" icon={ArrowRight16}>Sign In</Button>
              {:else}
                <InlineLoading {status} {description} />
              {/if}
            </div>
          </Form>
        </Column>
      </Row>
    </Grid>
  </Tile>
</div>

<script>
  import { Tile, Grid, Row, Column, SkeletonPlaceholder } from 'carbon-components-svelte';

  export let profile;

  const getMonth = (id) => {
    return [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ][id - 1];
  };
</script>

<Tile>
  <Grid padding>
    <Row>
      <Column>
        <h1>Profile</h1>
      </Column>
    </Row>
    <SkeletonPlaceholder style="margin-bottom: 1.5rem" />
    <Row>
      <Column>
        <h4>{'TP Number: ' + profile.tp_number}</h4>
      </Column>
    </Row>
    <Row>
      <Column>
        <h4>{'Name: ' + profile.name}</h4>
      </Column>
    </Row>
    <Row>
      <Column>
        <h4>{'Gender: ' + (profile.gender === 'M' ? 'Male' : 'Female')}</h4>
      </Column>
    </Row>
    <Row>
      <Column>
        <h4>{'Course: ' + profile.course}</h4>
      </Column>
    </Row>
    <Row>
      <Column>
        <h4>{`Intake: ${getMonth(profile.intake_month)} ${profile.intake_year}`}</h4>
      </Column>
    </Row>
  </Grid>
</Tile>

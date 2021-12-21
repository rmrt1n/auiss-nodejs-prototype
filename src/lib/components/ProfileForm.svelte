<script>
  import {
    Tile,
    Grid,
    Row,
    Column,
    SkeletonPlaceholder,
    TextInput,
    RadioButtonGroup,
    RadioButton,
    ComboBox,
    Form,
    Button,
  } from 'carbon-components-svelte';
  import ArrowRight16 from 'carbon-icons-svelte/lib/ArrowRight16';

  export let tp_number;
  let name = '';
  let course = '';
  let gender = 'M'; // M | F
  let month = '';
  let year = '';

  const months = [
    { id: '0', text: 'January' },
    { id: '1', text: 'February' },
    { id: '2', text: 'March' },
    { id: '3', text: 'April' },
    { id: '4', text: 'May' },
    { id: '5', text: 'June' },
    { id: '6', text: 'July' },
    { id: '7', text: 'August' },
    { id: '8', text: 'September' },
    { id: '9', text: 'October' },
    { id: '10', text: 'November' },
    { id: '11', text: 'December' },
  ];

  const years = [...Array(30)].map((v, i) => ({
    id: i,
    text: new Date().getFullYear() - i,
  }));
</script>

<Tile>
  <Grid padding>
    <Row>
      <Column>
        <h1>Update Profile</h1>
      </Column>
    </Row>
    <Row>
      <Column>
        <SkeletonPlaceholder style="margin-bottom: 1.5rem" />
        <Form>
          <Row>
            <Column>
              <h2>{tp_number.toUpperCase()}</h2>
            </Column>
          </Row>
          <Row>
            <Column>
              <TextInput
                required={true}
                labelText="Name"
                placeholder="Your name"
                bind:value={name}
              />
            </Column>
          </Row>
          <Row>
            <Column>
              <RadioButtonGroup bind:selected={gender}>
                <RadioButton labelText="Male" value="M" />
                <RadioButton labelText="Female" value="F" />
              </RadioButtonGroup>
            </Column>
          </Row>
          <Row>
            <Column>
              <TextInput
                required={true}
                labelText="Course"
                placeholder="Your course"
                bind:value={course}
              />
            </Column>
          </Row>
          <Row>
            <Column>
              <ComboBox
                titleText="Intake year"
                placeholder="Your intake year"
                items={years}
                bind:value={year}
              />
            </Column>
          </Row>
          <Row>
            <Column>
              <ComboBox
                titleText="Intake month"
                placeholder="Your intake month"
                items={months}
                bind:value={month}
              />
            </Column>
          </Row>
          <Row>
            <Column>
              <Button tyep="submit" icon={ArrowRight16}>Sign In</Button>
            </Column>
          </Row>
        </Form>
      </Column>
    </Row>
  </Grid>
</Tile>

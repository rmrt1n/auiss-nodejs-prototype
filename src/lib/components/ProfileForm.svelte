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
  import { supabase } from '$lib/db';

  export let id, tp_number, role;

  let name, course, month, year;
  name = course = month = year = '';
  let gender = 'M'; // M | F

  let invalidName, invalidCourse, invalidMonth, invalidYear;
  invalidName = invalidCourse = invalidMonth = invalidYear = false;

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

  const isValidInput = () => {
    if (name.trim() === '') {
      invalidName = true;
      return false;
    }
    if (course.trim() === '') {
      invalidCourse = true;
      return false;
    }
    if (!years.some((y) => y.text === year)) {
      invalidYear = true;
      return false;
    }
    if (!months.some((m) => m.text === month)) {
      invalidMonth = true;
      return false;
    }
    return true;
  };

  const monthDiff = (d1, d2) => {
    let diff = (d1.getTime() - d2.getTime()) / 1000;
    diff /= 60 * 60 * 24 * 7 * 4;
    return Math.abs(Math.round(diff));
  };

  const onSubmit = async () => {
    if (!isValidInput()) return;
    const intake = new Date(year, month, 1);
    year = parseInt(year);
    // https://stackoverflow.com/questions/13566552/easiest-way-to-convert-month-name-to-month-number-in-js-jan-01
    month = new Date(Date.parse(month + ' 1, 2021')).getMonth() + 1;
    const diff = monthDiff(new Date(), intake);
    const newRole = diff >= 36 ? 'alumni' : 'student';

    const { error: e1 } = await supabase
      .from('profiles')
      .update({
        name: name,
        course: course,
        gender: gender,
        intake_year: year,
        intake_month: month,
      })
      .eq('id', id);
    if (e1) console.log(e1.message);

    const { error: e2 } = await supabase.from('user_roles').update({ role: newRole }).eq('id', id);
    if (e2) console.log(e2.message);
    role = newRole;
  };
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
        <Form on:submit={onSubmit}>
          <Row>
            <Column>
              <h2>{tp_number}</h2>
            </Column>
          </Row>
          <Row>
            <Column>
              <TextInput
                required={true}
                labelText="Name"
                placeholder="Your name"
                bind:value={name}
                bind:invalid={invalidName}
                invalidText="Name cannot be empty"
                on:change={() => (invalidName = false)}
              />
            </Column>
          </Row>
          <Row>
            <Column>
              <RadioButtonGroup legendText="Gender" bind:selected={gender}>
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
                bind:invalid={invalidCourse}
                invalidText="Course cannot be empty"
                on:change={() => (invalidCourse = false)}
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
                bind:invalid={invalidYear}
                invalidText="Not a valid Year"
                on:change={() => (invalidYear = false)}
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
                bind:invalid={invalidMonth}
                invalidText="Not a valid Month"
                on:change={() => (invalidMonth = false)}
              />
            </Column>
          </Row>
          <Row>
            <Column>
              <Button type="submit" icon={ArrowRight16}>Sign In</Button>
            </Column>
          </Row>
        </Form>
      </Column>
    </Row>
  </Grid>
</Tile>

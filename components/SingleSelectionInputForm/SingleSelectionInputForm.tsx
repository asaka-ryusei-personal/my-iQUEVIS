import { Form } from "react-bootstrap";
import styles from "./SingleSelectionInputForm.module.css";

export type SingleSelectionInputFormProps = {
  questionId: number;
  questionTitle: string;
  isRequired: boolean;
  description?: string;
  options: string[];
  isDisabled?: boolean;
  isChecked?: boolean[];
};

export default function SingleSelectionInputForm({
  questionId,
  questionTitle,
  isRequired,
  description,
  options,
  isDisabled = false,
  isChecked,
}: SingleSelectionInputFormProps) {
  return (
    <>
      <Form.Group>
        <Form.Label className={styles.questionTitle}>
          {questionId}. {questionTitle}
          <span className={styles.isRequired}>{isRequired ? "*" : ""}</span>
        </Form.Label>
        <br />
        <Form.Text className="text-muted">{description}</Form.Text>

        {options.map((options, idx) => (
          <Form.Check
            disabled={isDisabled}
            type="radio"
            label={options}
            // checked={isChecked ? isChecked[idx] : false}
            name={`single-select-${questionId}`}
          />
        ))}
      </Form.Group>
    </>
  );
}

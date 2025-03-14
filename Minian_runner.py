import argparse
import asyncio
import sys
import subprocess
import os
import nbformat
from nbconvert.preprocessors import ExecutePreprocessor
from pathlib import Path
from termcolor import colored
import io
from contextlib import redirect_stdout, redirect_stderr

os.system('color')

if sys.platform.startswith("win"):
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())

# Default notebook path
DEFAULT_NOTEBOOK_PATH = "C:/Users/axelle.piguet/MiniscopeAnimalParam.ipynb"
DEFAULT_CROSSREG_PATH = "C:/Users/axelle.piguet/cross-registration.ipynb"  # to fixxxxxxx

def run_notebook(notebook_path, session):
    """Run a Jupyter notebook with a given session."""
    notebook_path = Path(notebook_path)
    if not notebook_path.exists():
        raise FileNotFoundError(f"Notebook {notebook_path} does not exist.")
    
    # Set the session path as an environment variable
    os.environ["SESSION_PATH"] = session or ""
    
    # Suppress output
    output_buffer = io.StringIO()
    try:
        with redirect_stdout(output_buffer), redirect_stderr(output_buffer):
            with open(notebook_path, "r", encoding="utf-8") as f:
                notebook = nbformat.read(f, as_version=4)
            ep = ExecutePreprocessor(timeout=600, kernel_name="python3")
            ep.preprocess(notebook, {'metadata': {'path': notebook_path.parent}})
        
        # Print your custom colored message
        print(colored("Notebook executed successfully." , 'green'))
    except Exception as e:
        print(colored(f"Error during execution: {e}" , 'red'))

def run_crossreg(notebook_path, mouse):
    """Run a Jupyter notebook with a given session."""
    notebook_path = Path(notebook_path)
    if not notebook_path.exists():
        raise FileNotFoundError(f"Notebook {notebook_path} does not exist.")
    
    # Set the session path as an environment variable
    os.environ["ANIMAL_PATH"] = mouse or ""
    
    # Suppress output
    output_buffer = io.StringIO()
    try:
        with redirect_stdout(output_buffer), redirect_stderr(output_buffer):
            with open(notebook_path, "r", encoding="utf-8") as f:
                notebook = nbformat.read(f, as_version=4)
            ep = ExecutePreprocessor(timeout=600, kernel_name="python3")
            ep.preprocess(notebook, {'metadata': {'path': notebook_path.parent}})
        
        # Print your custom colored message
        print(colored("Notebook executed successfully." , 'green'))
    except Exception as e:
        print(colored(f"Error during execution: {e}" , 'red'))


def open_notebook(notebook_path):
    """Open the notebook in Jupyter Notebook."""
    subprocess.run(["jupyter", "notebook", notebook_path])

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Run or open a Jupyter Notebook.")
    parser.add_argument(
        "--run", 
        action="store_true", 
        help="Run the notebook and print outputs."
    )
    parser.add_argument(
        "--cross_reg", 
        action="store_true", 
        help="Open the notebook in Jupyter Notebook."
    )
    parser.add_argument(
        "--tuning", 
        action="store_true", 
        help="Open the notebook in Jupyter Notebook."
    )
    parser.add_argument(
        "--session", 
        type=str, 
        default="", 
        help="Provide the path to the session."
    )
    parser.add_argument(
        "--mouse", 
        type=str, 
        default="", 
        help="Provide the path to the animal folder."
    )
    
    args = parser.parse_args()
    
    # Use default notebook path
    notebook_path = DEFAULT_NOTEBOOK_PATH
    cross_reg_path = DEFAULT_CROSSREG_PATH
    
    if args.run:
        run_notebook(notebook_path, args.session)
    elif args.tuning:
        open_notebook(notebook_path)
    elif args.cross_reg:
        run_crossreg(cross_reg_path, args.mouse)
    else:
        print("Please specify : --run to execute | --tuning to open the notebook.")